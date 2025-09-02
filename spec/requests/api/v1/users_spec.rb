# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let(:user) { create(:user) }

  describe 'GET /api/v1/users/:id/favorite_channel_programs' do
    it 'returns favorite channel programs ordered by time watched' do
      program1 = create(:channel_program)
      program2 = create(:channel_program)

      create(:most_watched, user: user, channel_program: program1, time_overall: 7200)
      create(:most_watched, user: user, channel_program: program2, time_overall: 3600)

      get "/api/v1/users/#{user.id}/favorite_channel_programs"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']).to be_an(Array)
      expect(json['result'].length).to eq(2)

      expect(json['result'][0]['id']).to eq(program1.id)
      expect(json['result'][0]['time_watched']).to eq(7200)
      expect(json['result'][1]['id']).to eq(program2.id)
      expect(json['result'][1]['time_watched']).to eq(3600)
    end
  end

  describe 'GET /api/v1/users/:id/favorite_provider_apps' do
    it 'returns favorite provider apps ordered by position' do
      app1 = create(:provider_app)
      app2 = create(:provider_app)

      create(:favorite, user: user, provider_app: app1, order_num: 2)
      create(:favorite, user: user, provider_app: app2, order_num: 1)

      get "/api/v1/users/#{user.id}/favorite_provider_apps"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']).to be_an(Array)
      expect(json['result'].length).to eq(2)

      expect(json['result'][0]['id']).to eq(app2.id)
      expect(json['result'][0]['position']).to eq(1)
      expect(json['result'][1]['id']).to eq(app1.id)
      expect(json['result'][1]['position']).to eq(2)
    end
  end

  describe 'POST /api/v1/users/:id/favorite_provider_app' do
    let(:provider_app) { create(:provider_app) }

    it 'creates favorite provider app with position' do
      post "/api/v1/users/#{user.id}/favorite_provider_app",
           params: { favorite: { provider_app_id: provider_app.id, order_num: 1 } }

      expect(response).to have_http_status(:created)
      json = response.parsed_body
      expect(json['result']['message']).to eq('Provider app favorited successfully')

      favorite = user.favorites.first
      expect(favorite.provider_app).to eq(provider_app)
      expect(favorite.order_num).to eq(1)
    end

    it 'returns validation error for duplicate position' do
      create(:favorite, user: user, provider_app: provider_app, order_num: 1)

      post "/api/v1/users/#{user.id}/favorite_provider_app",
           params: { favorite: { provider_app_id: create(:provider_app).id, order_num: 1 } }

      expect(response).to have_http_status(:unprocessable_content)
      json = response.parsed_body
      expect(json['error']).to eq('Validation failed')
    end

    it 'returns 404 for non-existent user' do
      post '/api/v1/users/999/favorite_provider_app',
           params: { favorite: { provider_app_id: provider_app.id, order_num: 1 } }

      expect(response).to have_http_status(:not_found)
    end
  end
end
