# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ProviderApps', type: :request do
  let(:provider_app) { create(:provider_app) }

  describe 'GET /api/v1/provider_apps/:id' do
    it 'returns provider_app with content fields' do
      get "/api/v1/provider_apps/#{provider_app.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']['id']).to eq(provider_app.id)
      expect(json['result']['created_at']).to be_present
      expect(json['result']['name']).to eq(provider_app.content.original_name)
      expect(json['result']['year']).to eq(provider_app.content.year)
    end

    it 'returns 404 for non-existent provider_app' do
      get '/api/v1/provider_apps/999'

      expect(response).to have_http_status(:not_found)
      json = response.parsed_body
      expect(json['error']).to eq('Not Found')
    end
  end
end
