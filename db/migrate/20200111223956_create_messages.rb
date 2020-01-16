class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|

      t.integer :number, null: false
      t.text :content, null: false
      t.string :email, limit: 100
      t.integer :chat_number, null: false
      t.string :application_token

      t.references :application, null: false
      t.references :chat, null: false

      t.timestamps

      t.index [:application_token, :chat_number]
    end
  end
end
