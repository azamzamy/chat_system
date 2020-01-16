class AddIndexToChats < ActiveRecord::Migration[5.1]
  def change
    add_index :chats, :application_token
    add_index :chats, [:number, :application_token], unique: true
  end
end
