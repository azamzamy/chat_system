class Chat < ApplicationRecord
  include CounterUpdater
  
  belongs_to :application, foreign_key: :application_token, primary_key: :token
  has_many :messages
  
  before_validation :assign_application_id
  
  validates_associated :application

  after_validation :generate_chat_number

  def assign_application_id
    application = Application.find_by(token: self.application_token)
    self.application_id = application.id
  end

  def generate_chat_number
    counter_key = "application:#{self.application_id}:chats_counter"
    counter_lock = "application:#{self.application_id}:chats_counter_lock"
    # If key did not previously exist, initialize and set to 1
    new_counter_value = REDIS.incr(counter_key)
    self.number = new_counter_value
    unless REDIS.exists(counter_lock)
      CounterUpdater.update_chats_counter(application_id, new_counter_value)
      REDIS.set(counter_lock, 1, ex: 1.minute)
    end
  end

end