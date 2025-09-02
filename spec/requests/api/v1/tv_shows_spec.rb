# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::TvShows', type: :request do
  let(:tv_show) { create(:tv_show) }

  describe 'GET /api/v1/tv_shows/:id' do
    it 'returns tv_show with all fields' do
      get "/api/v1/tv_shows/#{tv_show.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']['id']).to eq(tv_show.id)
      expect(json['result']['created_at']).to be_present
      expect(json['result']['title']).to eq(tv_show.content.original_name)
      expect(json['result']['year']).to eq(tv_show.content.year)
    end

    it 'returns 404 for non-existent tv_show' do
      get '/api/v1/tv_shows/999'

      expect(response).to have_http_status(:not_found)
    end
  end
end
