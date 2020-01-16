class Application < ApplicationRecord

  has_many :chats, foreign_key: :application_token, primary_key: :token

  validates_uniqueness_of :name
  
  before_create :generate_token

  def generate_token
    self.token = SecureRandom.base58(24)
  end
end

