class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :per_app_id
      t.references :application, foreign_key: true
      t.integer :message_count

      t.timestamps
    end
  end
end
