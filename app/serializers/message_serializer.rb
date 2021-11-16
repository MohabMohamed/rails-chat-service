class MessageSerializer
  def initialize(message)
    @message = message
  end

  def as_json
    {
      per_chat_id: message.per_chat_id,
      body: message.body
    }
  end

  private

  attr_reader :message
end
