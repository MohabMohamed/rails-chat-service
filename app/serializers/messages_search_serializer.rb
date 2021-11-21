class MessagesSearchSerializer
  def initialize(messages)
    @messages = messages
  end

  def as_json
    messages.map do |message|
      featched_message = Message.find(message.id)
      {
        per_chat_id: featched_message.per_chat_id,
        body: message.body
      }
    end
  end

  private

  attr_reader :messages
end
