FactoryBot.define do
  factory :message do
    per_chat_id { 1 }
    chat { nil }
    body { 'MyText' }
  end
end
