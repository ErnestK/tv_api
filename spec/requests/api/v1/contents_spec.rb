# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Contents', type: :request do
  let(:us_country) { Country.create!(name: 'United States', code: 'US') }
  let(:uk_country) { Country.create!(name: 'United Kingdom', code: 'GB') }

  let(:movie) { create(:movie) }
  let(:tv_show) { create(:tv_show) }
  let(:provider_app) { create(:provider_app) }

  before do
    Availability.create!(content: movie.content, provider_app: provider_app, country: us_country)
    Availability.create!(content: tv_show.content, provider_app: provider_app, country: us_country)

    Availability.create!(content: movie.content, provider_app: provider_app, country: uk_country)
  end

  describe 'GET /api/v1/contents' do
    it 'returns all content for country when no type filter' do
      get '/api/v1/contents', params: { country: 'US' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']).to be_an(Array)
      expect(json['result'].length).to eq(2) # movie + tv_show

      content_types = json['result'].pluck('contentable_type')
      expect(content_types).to include('Movie', 'TvShow')
    end

    it 'returns correct field values for content' do
      get '/api/v1/contents', params: { country: 'US', type: 'movie' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result'].length).to eq(1)
      content_item = json['result'][0]

      expect(content_item['original_name']).to eq(movie.content.original_name)
      expect(content_item['year']).to eq(movie.content.year)
      expect(content_item['contentable_type']).to eq('Movie')
      expect(content_item['created_at']).to eq(movie.content.created_at.iso8601(3))
      expect(content_item['content_id']).to eq(movie.id)
    end

    it 'filters content by type' do
      get '/api/v1/contents', params: { country: 'US', type: 'movie' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result'].length).to eq(1)
      expect(json['result'][0]['contentable_type']).to eq('Movie')
      expect(json['result'][0]['original_name']).to eq(movie.content.original_name)
    end

    it 'returns different results for different countries' do
      get '/api/v1/contents', params: { country: 'GB' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result'].length).to eq(1) # only movie available in GB
      expect(json['result'][0]['contentable_type']).to eq('Movie')
    end

    it 'returns 400 for invalid content type' do
      get '/api/v1/contents', params: { country: 'US', type: 'invalid_type' }

      expect(response).to have_http_status(:bad_request)
      json = response.parsed_body
      expect(json['error']).to eq('Bad Request')
      expect(json['message']).to include('Invalid content type: invalid_type')
    end

    it 'returns 404 for invalid country' do
      get '/api/v1/contents', params: { country: 'INVALID' }

      expect(response).to have_http_status(:not_found)
    end

    it 'requires country parameter' do
      get '/api/v1/contents'

      expect(response).to have_http_status(:bad_request) # ArgumentError → 400 Bad Request
      json = response.parsed_body
      expect(json['error']).to eq('Bad Request')
      expect(json['message']).to eq('Country parameter is required')
    end
  end
end
