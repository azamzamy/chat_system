class MessagesController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    application_token = params.require(:token)
    chat_number = params.require(:chat_number)
    
    @messages = Message.where(application_token: application_token, chat_number: chat_number)
    @messages_array = Array.new
    @messages.each do |msg|
      @messages_array << {
        message_number: msg.number,
        from: msg.email,
        content: msg.content,
        application_token: msg.application_token,
        chat_number: msg.chat_number,
        created_at: msg.created_at 
      }
    end

    render json: @messages_array
  end

  def show
    application_token = params.require(:token)
    chat_number = params.require(:chat_number)

    @message = Message.find_by(application_token: application_token)
    
    render json: {
      message_number: @message.number,
      from: @message.email,
      content: @message.content,
      application_token: @message.application_token,
      chat_number: @message.chat_number,
      created_at: @message.created_at
    }
  end

  def create
    application_token = params.require(:token)
    chat_number = params.require(:chat_number)
    content = params.require(:content)
    email = params.permit(:email)
    
    @message = Message.new(application_token: application_token, chat_number: chat_number, content: content, email: email)
    @message.save!

    render json: {
      message_number: @message.number,
      from: @message.email,
      content: @message.content,
      application_token: @message.application_token,
      chat_number: @message.chat_number,
      created_at: @message.created_at
    }
  end
end
