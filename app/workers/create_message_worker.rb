# app/workers/create_message_worker.rb

class CreateMessageWorker
  include Sidekiq::Worker
  
  def perform(application_token, chat_number, content, email)
    @message = Message.new(application_token: application_token, chat_number: chat_number, content: content, email: email)
    # We don't usually assign parents from controllers but I have a good reason
    @message.chat = Chat.find_by(application_token: application_token, number: chat_number)
    @message.save
  end

end