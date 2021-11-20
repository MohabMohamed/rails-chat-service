class AddInsertChatsTrigger < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      CREATE TRIGGER create_new_chat
      BEFORE INSERT
      ON chats FOR EACH ROW
    
      BEGIN
        DECLARE max_id BIGINT;
        SELECT (SELECT per_app_id
        FROM chats c 
        WHERE application_id = NEW.application_id
        ORDER BY per_app_id DESC 
        limit 1) INTO max_id;
      SET NEW.per_app_id = coalesce(max_id, 0) + 1;
      END

    SQL
  end
end
