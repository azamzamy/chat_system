class ApplicationsController < ApplicationController
  protect_from_forgery with: :null_session
  
  def index
    @applications = Application.order(:id)

    render json: JSONAPI::Serializer.serialize(@applications, is_collection: true)
  end

  def show
    application_token = params.require(:token)

    @application = Application.where(token: application_token).first

    render json: {
      name: @application.name,
      application_token: @application.token,
      chats_counter: @application.chats_counter,
      created_at: @application.created_at
    }
  end

  def create
    name = params.require(:name)
    
    @application = Application.new(name: name)
    @application.save!
    
    render json: {
      status: "success",
      application: {
        name: @application.name,
        application_token: @application.token,
        chats_counter: @application.chats_counter,
        created_at: @application.created_at
      }
    }
  end

  def update_name
    token = params.require(:token)
    name = params.require(:name)

    @application = Application.find_by(token: token)
    
    if @application.update_attributes(name: name)
      render json: {
        status: 'success' 
      }
    else
      render json: {
        status: 'An error occured.',
        error: @application.errors.messages
      }
    end
  end

end
