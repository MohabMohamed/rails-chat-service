FactoryBot.define do
  factory :chat do
    per_app_id { 1 }
    application { nil }
    message_count { 1 }
  end
end
