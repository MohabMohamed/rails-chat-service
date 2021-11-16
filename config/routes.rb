Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'health', to: 'health#check'
      scope '/applications' do
        post '/', to: 'applications#create'
        get  '/:token', to: 'applications#show'
        patch '/:token', to: 'applications#update'
        delete '/:token', to: 'applications#destroy'

        scope '/:token/chats' do
          get '/', to: 'chats#index'
          get '/:chat_num', to: 'chats#show'
          delete '/:chat_num', to: 'chats#destroy'
          scope '/:chat_num/messages' do
            get '/', to: 'messages#index'
            get '/:message_num', to: 'messages#show'
            delete '/:message_num', to: 'messages#destroy'
            patch '/:message_num', to: 'messages#update'
          end
        end
      end
      mount Rswag::Ui::Engine => '/api-docs'
      mount Rswag::Api::Engine => '/api-docs'
    end
  end
end
