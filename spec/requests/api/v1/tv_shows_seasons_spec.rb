# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::TvShowsSeasons', type: :request do
  let(:season) { create(:tv_shows_season) }

  describe 'GET /api/v1/tv_shows_seasons/:id' do
    it 'returns season with all fields' do
      get "/api/v1/tv_shows_seasons/#{season.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']['id']).to eq(season.id)
      expect(json['result']['tv_show_id']).to eq(season.tv_show_id)
      expect(json['result']['number']).to eq(season.number)
      expect(json['result']['created_at']).to be_present
      expect(json['result']['title']).to eq(season.content.original_name)
      expect(json['result']['year']).to eq(season.content.year)
    end

    it 'returns 404 for non-existent season' do
      get '/api/v1/tv_shows_seasons/999'

      expect(response).to have_http_status(:not_found)
    end
  end
end
