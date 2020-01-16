Rails.application.routes.draw do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Applications Routes
  get '/applications/:token', to: 'applications#show'
  post '/applications/:name', to: 'applications#create'
  get '/applications', to: 'applications#index'

  # Chats Routes
  get '/applications/:token/chats', to: 'chats#index'
  get '/applications/:token/chats/:chat_number', to: 'chats#show'
  post '/applications/:token/chats', to: 'chats#create'

  # Messages Routes
  get '/applications/:token/chats/:chat_number/messages', to: 'messages#index'
  get '/applications/:token/chats/:chat_number/:message_number', to: 'messages#show'
  post '/applications/:token/chats/:chat_number', to: 'messages#create'
end
