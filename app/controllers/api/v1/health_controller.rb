module Api
  module V1
    class HealthController < ApplicationController
      def check
        render json: { up: true }, status: :ok
      end
    end
  end
end
