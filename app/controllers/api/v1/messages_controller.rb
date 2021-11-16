module Api
  module V1
    class MessagesController < ApplicationController
      before_action :set_message, only: %i[show destroy]
      before_action :set_messages, only: %i[index]

      # GET /applications/:token/chats/:chat_num/messages
      def index
        render json: MessagesSerializer.new(@messages).as_json
      end

      # GET /applications/:token/chats/:chat_num/:chat_num/messages/:message_num
      def show
        render json: MessageSerializer.new(@message).as_json
      end

      # DELETE /applications/:token/chats/:chat_num/:chat_num/messages/:message_num
      def destroy
        @message.destroy!
        head :no_content
      end

      private

      def set_messages
        @application = Application.includes(:chats, { chats: :messages }).where(token: params[:token]).first
        head :not_found if @application.nil? || application.chats.nil? || application.chats.messages.nil?
        @messages = application.chats[0].messages
      end

      def set_message
        @application = Application.find_by(token: params[:token])
        head :not_found if @application.nil?

        @chat = Chat.find_by(per_app_id: params[:chat_num])
        head :not_found if @chat.nil?

        @message = Message.find_by(per_chat_id: params[:message_num])
        head :not_found if @message.nil?
      end
    end
  end
end
