class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :chat
  validates :body, presence: true
  mappings dynamic: false do
    indexes :chat_id :int
    indexes :id, type: :int
    indexes :body, type: :text, analyzer: :english
  end
end
