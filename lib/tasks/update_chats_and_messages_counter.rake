desc 'Update database columns chats_count and messages_count in applications and chats tables'
task update_counters: :environment do
  sql = "UPDATE applications
  SET chat_count =
  (SELECT COUNT(*) from chats
  WHERE chats.application_id = applications.id);"
  ActiveRecord::Base.connection.execute(sql)

  sql = "UPDATE chats
  SET message_count =
  (SELECT COUNT(*) from messages
  WHERE messages.chat_id = chats.id);"
  ActiveRecord::Base.connection.execute(sql)
end

