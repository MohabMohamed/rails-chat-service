module Api
  module V1
    class ApplicationsController < ApplicationController
      before_action :set_application, only: %i[show update destroy]

      # GET /applications/:token
      def show
        render json: ApplicationSerializer.new(@application).as_json
      end

      # POST /applications
      def create
        application = Application.new(application_params)

        if application.save
          render json: ApplicationSerializer.new(application).as_json, status: :created
        else
          render json: application.errors, status: :bad_request
        end
      end

      # PATCH/PUT /applications/:token
      def update
        if @application.update(application_params)
          render json: ApplicationSerializer.new(@application).as_json
        else
          render json: @application.errors, status: :bad_request
        end
      end

      # DELETE /applications/:token
      def destroy
        @application.destroy!

        head :no_content
      end

      private

      def set_application
        @application = Application.find_by(token: params[:token])
        head :not_found if @application.nil?
      end

      def application_params
        params.require(:application).permit(:name)
      end
    end
  end
end
