require 'securerandom'

class Application < ApplicationRecord
  before_create :set_uuid

  validates :name, presence: true

  private

  def set_uuid
    self.token = SecureRandom.uuid
  end
end
