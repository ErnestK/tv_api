# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Movies', type: :request do
  let(:movie) { create(:movie) }

  describe 'GET /api/v1/movies/:id' do
    it 'returns movie with content' do
      get "/api/v1/movies/#{movie.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      result = json['result']
      expect(result['id']).to eq(movie.id)
      expect(result['duration_in_seconds']).to eq(movie.duration_in_seconds)
      expect(result['created_at']).to be_present
      expect(result['title']).to be_present
      expect(result['year']).to be_present
    end

    it 'returns 404 for non-existent movie' do
      get '/api/v1/movies/999'

      expect(response).to have_http_status(:not_found)
      json = response.parsed_body
      expect(json['error']).to eq('Not Found')
    end
  end
end
