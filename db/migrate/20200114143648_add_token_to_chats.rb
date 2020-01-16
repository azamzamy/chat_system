class AddTokenToChats < ActiveRecord::Migration[5.1]
  def change
    add_column :chats, :application_token, :string
  end
end
