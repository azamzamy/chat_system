class CreateChats < ActiveRecord::Migration[5.1]
  def change
    create_table :chats do |t|

      t.integer :number, null: false
      t.integer :messages_counter, default: 0
      
      t.references :application, null: false

      t.timestamps

      t.index [:number]
    end
  end
end
