require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'api/v1/health', type: :request do
  it 'Health docs' do
    path '/api/v1/health' do
      get('check health') do
        tags 'Health'
        response(200, 'Health ok') do
          run_test!
        end
      end
    end
  end
  it 'test GET /Health' do
    get '/api/v1/health'

    expect(response).to have_http_status(:ok)
    expect(response_body).to eq({ 'up' => true })
  end
end
