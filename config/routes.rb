Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # Applications Routes
  get '/applications/:token', to: 'applications#show'
  get '/applications', to: 'applications#index'
  post '/applications/:name', to: 'applications#create'
  post '/applications/:token/edit', to: 'applications#update_name'

  # Chats Routes
  get '/applications/:token/chats', to: 'chats#index'
  get '/applications/:token/chats/:chat_number', to: 'chats#show'
  post '/applications/:token/chats', to: 'chats#create'
  get '/applications/:token/chats/:chat_number/search', to: 'chats#search'

  # Messages Routes
  get '/applications/:token/chats/:chat_number/messages', to: 'messages#index'
  get '/applications/:token/chats/:chat_number/messages/:message_number', to: 'messages#show'
  post '/applications/:token/chats/:chat_number/messages', to: 'messages#create'
end
