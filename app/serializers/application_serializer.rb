class ApplicationSerializer
  def initialize(application)
    @application = application
  end

  def as_json
    {
      token: application.token,
      name: application.name
    }
  end

  private

  attr_reader :application
end
