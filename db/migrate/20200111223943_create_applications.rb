class CreateApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :applications do |t|
      
      t.string :name, limit: 100, null: false
      t.string :token, unique: true
      t.integer :chats_counter, default: 0

      t.timestamps

      t.index [:name]
      t.index [:token]
    end
  end
end
