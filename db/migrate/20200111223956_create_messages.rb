class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|

      t.integer :number, null: false
      t.text :content, null: false
      t.string :email, limit: 100

      t.timestamps

      t.references :chat, null: false

      t.index [:number, :chat_id]
    end
  end
end
