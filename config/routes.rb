# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'health', to: 'health#check'
      mount Rswag::Ui::Engine => '/api-docs'
      mount Rswag::Api::Engine => '/api-docs'
    end
  end
end
