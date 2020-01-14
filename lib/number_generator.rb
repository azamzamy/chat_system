module NumberGenerator
  def self.generate_chat_number(application_id, current_count = 0)
    chats_counter_key = "application:#{application_id}:chats_counter"
    counter_lock = "application:#{application_id}:counter_lock"
    
    if !REDIS.exists(chats_counter_key)
      REDIS.set(chats_counter_key, current_count)
    end

    updated_count = REDIS.incr(chats_counter_key)
    return updated_count if REDIS.exists(counter_lock)
    
    update_counters(application_id)
    REDIS.set(counter_lock, 1, ex: 5.minutes)
    
    updated_count
  end

  def self.increment_messages_counter(application_id, current_count = 0)
    messages_counter_key = "application:#{application_id}:messages_counter"
    
    REDIS.incr(messages_counter_key)
  end
end
