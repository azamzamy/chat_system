module CounterUpdater
  extend ActiveSupport::Concern
  def self.update_chats_counter(application_id, chats_counter)
    application = Application.find(application_id)
    if application.chats_counter < get_chats_counter_value(application_id)
      counter_value = get_chats_counter_value(application_id)
      application.update_column(:chats_counter, counter_value)
    end
  end

  def self.update_messages_counter(chat_id, messages_counter)
    chat = Chat.find(chat_id)
    if chat.messages_counter < get_messages_counter_value(chat_id)
      counter_value = get_messages_counter_value(chat_id)
      chat.update_column(:messages_counter, counter_value)
    end
  end

  def self.get_chats_counter_value(application_id)
    counter_key = "application:#{application_id}:chats_counter"
    REDIS.get(counter_key).to_i
  end

  def self.get_messages_counter_value(chat_id)
    counter_key = "chat:#{chat_id}:messages_counter"
    REDIS.get(counter_key).to_i
  end
end