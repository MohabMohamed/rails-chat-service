class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :per_chat_id
      t.references :chat, foreign_key: true
      t.text :body

      t.timestamps
    end
  end
end
