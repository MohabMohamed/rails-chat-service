class ChatsSerializer
  def initialize(chats)
    @chats = chats
  end

  def as_json
    chats.map do |chat|
      {
        per_app_id: chat.per_app_id,
        message_count: chat.message_count
      }
    end
  end

  private

  attr_reader :chats
end
