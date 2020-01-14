class Application < ApplicationRecord

  has_many :chats

  validates_uniqueness_of :name
  
  before_create :generate_token

  def generate_token
    update_column(token: SecureRandom.base58(24))
  end

  def sync_chats_counter
    if chats_counter < get_counter_value
      counter_value = get_counter_value
      update_column(chats_counter: counter_value)
    end
  end

  def get_counter_value
    REDIS.get(chats_counter_key).to_i
  end

  def chats_counter_key
    "application:#{application_id}:chats_counter"
  end
  
end

