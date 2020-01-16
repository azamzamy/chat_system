class ChatsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    application_token = params.require(:token)
    
    @chats = Chat.where(application_token: application_token)
    @chats_array = Array.new
    @chats.each do |chat|
      @chats_array << {
        chat_number: chat.number,
        application_token: chat.application_token,
        messages_counter: chat.messages_counter,
        created_at: chat.created_at,
      }
    end

    render json: @chats_array
  end

  def show
    application_token = params.require(:token)
    chat_number = params.require(:chat_number)

    @chat = Chat.where(application_token: application_token, number: chat_number).first
    @application = Application.where(token: application_token).first
    
    render json: {
      chat_number: @chat.number,
      application_token: @chat.application_token,
      application_name: @application.name,
      messages_counter: @chat.messages_counter,
      created_at: @chat.created_at
    }
  end

  def create
    application_token = params.require(:token)

    @chat = Chat.new(application_token: application_token)
    @chat.save!

    render json: {
      response: "success",
      chat: {
        chat_number: @chat.number,
        application_token: @chat.application_token,
        messages_counter: @chat.messages_counter,
        created_at: @chat.created_at
      }
    }

  end

end
