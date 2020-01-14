class Chat < ApplicationRecord
    
  belongs_to :application, foreign_key: application.token, null: false
  has_many :messages
  
  before_create :generate_chat_number

  def generate_number
    self.number = generate_chat_number(application_id, application.chats_counter)
  end

  def self.generate_chat_number(application_id, current_count = 0)
    chats_counter_key = "application:#{application_id}:chats_counter"
    counter_lock = "application:#{application_id}:counter_lock"
    
    # if !REDIS.exists(chats_counter_key)
    #   REDIS.set(chats_counter_key, current_count)
    # end
    # new_counter_value = REDIS.incr(chats_counter_key)

    return new_counter_value if REDIS.exists(counter_lock)
    
    application.sync_chats_counter(new_counter_value)
    REDIS.set(counter_lock, 1, ex: 1.minute)
    
    new_counter_value
  end

end