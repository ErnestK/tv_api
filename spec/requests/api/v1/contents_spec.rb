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

      content_types = json['result'].map { |c| c['content']['type'] }
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
      expect(content_item['created_at']).to eq(movie.content.created_at.iso8601(3))

      expect(content_item['content']['id']).to eq(movie.id)
      expect(content_item['content']['type']).to eq('Movie')
    end

    it 'filters content by type' do
      get '/api/v1/contents', params: { country: 'US', type: 'movie' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result'].length).to eq(1)
      expect(json['result'][0]['content']['type']).to eq('Movie')
      expect(json['result'][0]['original_name']).to eq(movie.content.original_name)
    end

    it 'returns different results for different countries' do
      get '/api/v1/contents', params: { country: 'GB' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result'].length).to eq(1) # only movie available in GB
      expect(json['result'][0]['content']['type']).to eq('Movie')
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

      expect(response).to have_http_status(:bad_request)
      json = response.parsed_body
      expect(json['error']).to eq('Bad Request')
      expect(json['message']).to include('param is missing or the value is empty: country')
    end
  end

  describe 'GET /api/v1/contents/search' do
    let!(:interstellar_movie) { create(:movie).tap { |m| m.content.update!(original_name: 'Interstellar', year: 2014) } }
    let!(:dark_knight_movie) { create(:movie).tap { |m| m.content.update!(original_name: 'The Dark Knight', year: 2008) } }
    let!(:netflix_app) { create(:provider_app).tap { |a| a.content.update!(original_name: 'Netflix Mobile App', year: 2023) } }

    it 'searches content by title' do
      get '/api/v1/contents/search', params: { q: 'Interstellar' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      
      expect(json['result']).to be_an(Array)
      found_content = json['result'].find { |c| c['original_name'] == 'Interstellar' }
      expect(found_content).to be_present
      expect(found_content['content']['type']).to eq('Movie')
    end

    it 'searches content by year' do
      get '/api/v1/contents/search', params: { q: '2008' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      
      expect(json['result']).to be_an(Array)
      expect(json['result'].length).to be > 0
      
      # Find Dark Knight which has year 2008
      dark_knight_content = json['result'].find { |c| c['original_name'] == 'The Dark Knight' }
      expect(dark_knight_content).to be_present
      expect(dark_knight_content['year']).to eq(2008)
    end

    it 'searches by partial title' do
      get '/api/v1/contents/search', params: { q: 'Inter' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      
      found_content = json['result'].find { |c| c['original_name'] == 'Interstellar' }
      expect(found_content).to be_present
    end

    it 'searches provider app by name' do
      get '/api/v1/contents/search', params: { q: 'Netflix' }

      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      
      netflix_content = json['result'].find { |c| c['original_name'].include?('Netflix') }
      expect(netflix_content).to be_present
      expect(netflix_content['content']['type']).to eq('ProviderApp')
    end

    it 'returns 400 for missing query parameter' do
      get '/api/v1/contents/search'

      expect(response).to have_http_status(:bad_request)
      json = response.parsed_body
      expect(json['error']).to eq('Bad Request')
      expect(json['message']).to include('param is missing or the value is empty: q')
    end
  end
end
