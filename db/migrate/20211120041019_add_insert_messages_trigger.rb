class AddInsertMessagesTrigger < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      CREATE TRIGGER create_new_message
      BEFORE INSERT
      ON messages FOR EACH ROW
    
      BEGIN
        DECLARE max_id BIGINT;
        SELECT (SELECT per_chat_id
        FROM messages m 
        WHERE chat_id = NEW.chat_id
        ORDER BY per_chat_id DESC 
        limit 1) INTO max_id;
      SET NEW.per_chat_id = coalesce(max_id, 0) + 1;
      END
  
    SQL
  end
end
