class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotDestroyed, with: :not_destroyed
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  private

  def not_destroyed(err)
    render json: { errors: err.record.errors }, status: :unprocessable_entity
  end

  def not_found(err)
    render json: { errors: err.record.errors }, status: :not_found
  end

  def bad_request(err)
    render json: { errors: err.record.errors }, status: :bad_request
  end
end
