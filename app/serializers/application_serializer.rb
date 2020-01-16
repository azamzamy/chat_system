require 'jsonapi-serializers'

class ApplicationSerializer
  include JSONAPI::Serializer

  attributes :name, :token, :chats_counter, :updated_at

end