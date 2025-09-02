# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Channels', type: :request do
  let(:channel) { create(:channel) }

  describe 'GET /api/v1/channels/:id' do
    it 'returns channel with all fields' do
      get "/api/v1/channels/#{channel.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']['id']).to eq(channel.id)
      expect(json['result']['created_at']).to be_present
      expect(json['result']['title']).to eq(channel.content.original_name)
      expect(json['result']['year']).to eq(channel.content.year)
    end

    it 'returns 404 for non-existent channel' do
      get '/api/v1/channels/999'

      expect(response).to have_http_status(:not_found)
    end
  end
end
