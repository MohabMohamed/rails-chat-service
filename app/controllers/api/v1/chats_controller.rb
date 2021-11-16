module Api
  module V1
    class ChatsController < ApplicationController
      before_action :set_chat, only: %i[show destroy]
      before_action :set_chats, only: %i[index]

      # GET /applications/:token/chats
      def index
        render json: ChatsSerializer.new(@chats).as_json
      end

      # GET /applications/:token/chats/:chat_num
      def show
        render json: ChatSerializer.new(@chat).as_json
      end

      # DELETE /applications/:token/chats/:chat_num
      def destroy
        @chat.destroy!
        head :no_content
      end

      private

      def set_chats
        @application = Application.includes(:chats).where(token: params[:token]).first
        head :not_found if @application.nil? || application.chats.nil?
        @chats = application.chats
      end

      def set_chat
        @application = Application.find_by(token: params[:token])
        head :not_found if @application.nil?

        @chat = Chat.find_by(per_app_id: params[:chat_num])
        head :not_found if @chat.nil?
      end
    end
  end
end
