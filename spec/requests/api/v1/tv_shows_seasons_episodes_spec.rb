# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::TvShowsSeasonsEpisodes', type: :request do
  let(:episode) { create(:tv_shows_seasons_episode) }

  describe 'GET /api/v1/tv_shows_seasons_episodes/:id' do
    it 'returns episode with all fields' do
      get "/api/v1/tv_shows_seasons_episodes/#{episode.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']['id']).to eq(episode.id)
      expect(json['result']['tv_shows_season_id']).to eq(episode.tv_shows_season_id)
      expect(json['result']['number']).to eq(episode.number)
      expect(json['result']['duration_in_seconds']).to eq(episode.duration_in_seconds)
      expect(json['result']['created_at']).to be_present
      expect(json['result']['title']).to eq(episode.content.original_name)
      expect(json['result']['year']).to eq(episode.content.year)
    end

    it 'returns 404 for non-existent episode' do
      get '/api/v1/tv_shows_seasons_episodes/999'

      expect(response).to have_http_status(:not_found)
    end
  end
end
