class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  include CounterUpdater

  belongs_to :application, foreign_key: :application_token, primary_key: :token
  belongs_to :chat, optional: true
  
  validates_associated :application
  
  after_validation :assign_application_id
  after_validation :assign_chat_id
  after_validation :generate_message_number
  after_validation :check_value

  after_commit on: :update do
    self.index_content_in_elasticsearch
  end

  settings do
    mappings dynamic: false do
      indexes :content, type: :text
      indexes :chat_number, type: :integer
      indexes :application_token, type: :string
    end
  end

  def check_value
    puts "INSPECTOR:  #{self.inspect}"
  end

  def assign_application_id
    application = Application.where(token: self.application_token).first
    if application
    else
      raise "Null Exception"
    end
    self.application_id = application.id
  end

  def assign_chat_id
    self.chat = Chat.find_by(application_token: self.application_token, number: self.chat_number)
    self.chat_id = chat.id
  end

  def generate_message_number
    counter_key = "chat:#{self.chat_id}:messages_counter"
    counter_lock = "chat:#{self.chat_id}:messages_counter_lock"
    # If key did not previously exist, initialize and set to 1
    new_counter_value = REDIS.incr(counter_key)
    self.number = new_counter_value
    unless REDIS.exists(counter_lock)
      CounterUpdater.update_messages_counter(self.chat_id, new_counter_value)
      REDIS.set(counter_lock, 1, ex: 1.minute)
    end
  end

  def self.search_chat(query, application_token, chat_number)
    self.__elasticsearch__.search({
      query: {
        bool: {
          must: {
            multi_match: {
              query: query,
              analyzer: 'standard',
              fields: [:content]
            }
          },
          filter: [
            # { term: { application_token: application_token } },
            # { term: { chat_number: chat_number.to_i } }
          ]
        }
      }
    })
  end

  private

  def index_content_in_elasticsearch
    self.__elasticsearch__.index_document
  end

end
