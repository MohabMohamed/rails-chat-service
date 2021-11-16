class MessagesSerializer
  def initialize(messages)
    @messages = messages
  end

  def as_json
    messages.map do |message|
      {
        per_chat_id: message.per_chat_id,
        body: message.body
      }
    end
  end

  private

  attr_reader :messages
end
