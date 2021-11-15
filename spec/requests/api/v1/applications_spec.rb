require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/api/v1/applications', type: :request do
  describe 'application docs' do
    path '/api/v1/applications' do
      post 'Creates an application' do
        tags 'Application'
        consumes 'application/json'

        parameter name: :application, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: 'name'
        }

        response '201', 'Application created' do
          schema type: :object,
                 properties: {
                   name: { type: :string },
                   token: { type: :string }
                 }

          let(:application) { { name: 'An awesome application' } }
          run_test! do |response|
            expect(response).to have_http_status(:created)
          end
        end
        response '400', "Can't proccess parameters" do
          let(:application) { { not_name: 'A sneaky intruder' } }
          run_test! do |response|
            expect(response).to have_http_status(:bad_request)
          end
        end
      end
    end

    path '/api/v1/applications/{token}' do
      parameter name: :token, in: :path, type: :string
      get 'Get an application' do
        tags 'Application'
        produces 'application/json'

        response '200', 'Application found' do
          schema type: :object,
                 properties: {
                   name: { type: :string },
                   token: { type: :string }
                 }

          let(:token) { Application.create(name: 'more awesome application').token }
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response_body).to eq(
              'name' => 'more awesome application',
              'token' => token
            )
          end
        end
        response '404', 'Application with given token not found'
      end

      patch 'change name of an application' do
        tags 'Application'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :application, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: 'name'
        }

        response '200', 'Application Edited' do
          schema type: :object,
                 properties: {
                   name: { type: :string },
                   token: { type: :string }
                 }

          let(:token) { Application.create(name: 'more awesome application').token }
          let(:application) { { name: 'Super Duper app' } }
          run_test! do |response|
            expect(response).to have_http_status(:ok)
            expect(response_body).to eq(
              'name' => 'Super Duper app',
              'token' => token
            )
          end
        end
        response '404', 'Application with given token not found'
        response '400', "Can't proccess parameters" do
          let(:token) { Application.create(name: 'more awesome application').token }
          let(:application) { { not_name: 'A sneaky intruder' } }
          run_test! do |response|
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      delete 'Delete an application' do
        tags 'Application'
        produces 'application/json'

        response '204', 'Application deleted' do
          let(:token) { Application.create(name: 'sad deleted application').token }
          run_test! do |response|
            expect(response).to have_http_status(:no_content)
          end
        end
        response '404', 'Application with given token not found'
      end
    end
  end
end
