class ChatSerializer
  def initialize(chat)
    @chat = chat
  end

  def as_json
    {
      per_app_id: chat.per_app_id,
      message_count: chat.message_count
    }
  end

  private

  attr_reader :chat
end
