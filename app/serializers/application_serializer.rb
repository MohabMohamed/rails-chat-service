class ApplicationSerializer
  def initialize(application)
    @application = application
  end

  def as_json
    {
      token: application.token,
      name: application.name,
      chat_count: application.chat_count
    }
  end

  private

  attr_reader :application
end
