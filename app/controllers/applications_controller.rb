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

  # def application_params
  #   application = params.require(:application).permit(:name)
  # end


end
