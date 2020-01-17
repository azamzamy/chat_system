# Chat App

##### Run app using 

`docker-compose up`

### HTTP Requests to use to test the app

##### Show all applications
GET http://localhost:3000/applications/

##### Create new applications
POST http://localhost:3000/applications/messenger
POST http://localhost:3000/applications/chat_app
POST http://localhost:3000/applications/ping

##### Show an applications data
GET http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/

##### Show all chats for an application
GET http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats

##### Create a new chat
POST http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats

##### Show a chat's data
GET http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats

##### Show a chat's messages
GET http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats/5/messages

##### Create a new message in a given chat
http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats/5/messages?content=Hi there,&email=adam@gmail.com

##### Create a new message in a given chat
http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats/5/messages?content=hello world&email=adam@gmail.com

http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats/5/messages?content=Hi there,&email=adam@gmail.com

http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats/5/messages?content=it'sme&email=adam@gmail.com

##### Show a message's details
http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats/1/messages/1

##### Search for a keyword inside a given chat
http://localhost:3000/applications/eRGoVWFYiifYrw9hxt49v5yq/chats/1/search?query=rab
