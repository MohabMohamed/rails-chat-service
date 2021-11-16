class AddChatCountToApplication < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :chat_count, :integer
  end
end
