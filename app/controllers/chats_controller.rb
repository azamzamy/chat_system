class ChatsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    application_token = params.require(:token)
    
    @chats = Chat.where(application_token: application_token)
    return render json: {message: "No chats found. Create one."} unless @chats
    @chats_array = Array.new
    @chats.each do |chat|
      @chats_array << {
        chat_number: chat.number,
        application_token: chat.application_token,
        messages_counter: chat.messages_counter,
        created_at: chat.created_at
      }
    end

    render json: @chats_array, status: 200
  end

  def show
    application_token = params.require(:token)
    chat_number = params.require(:chat_number)

    @chat = Chat.find_by(application_token: application_token, number: chat_number)
    return render json: {message: "No chat was found"} unless @chat
    
    @application = Application.find_by(token: application_token)
    # @messages = Message.where(application_token: application_token, chat_number: chat_number)
    # @chats_page
    render json: {
      chat_number: @chat.number,
      application_token: @chat.application_token,
      application_name: @application.name,
      messages_counter: @chat.messages_counter,
      created_at: @chat.created_at
      }, status: 200
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
    }, status: 200
  end

  # Search through messages of a given chat using ElasticSearch
  def search
    application_token = params.require(:token)
    chat_number = params.require(:chat_number)
    query = params.require(:query)
    
    message = Message.find_by(application_token: application_token, chat_number: chat_number)
    return render json: { message: "No results matching your query." } unless message
    chat_id = message.chat_id
    messages, total_hits = execute_query(query, chat_id)
    return render json: { message: "No messages were found." } unless total_hits.value > 0
    render json: { messages_count: total_hits.value,
                   messages: messages },
           status: 200
  end

  def execute_query(es_query, chat_id)
    query_result = Message.search_chat(es_query, chat_id)
    total_hits = query_result.response['hits']['total']
    messages_array = Array.new
    messages = query_result.results.map do |msg|
      messages_array << {
        message_number: msg.number,
        from: msg.email,
        content: msg.content,
        application_token: msg.application_token,
        chat_number: msg.chat_number,
        created_at: msg.created_at 
      }
    end
    [messages_array, total_hits]
  end
end
