# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ChannelPrograms', type: :request do
  let(:program) { create(:channel_program) }

  describe 'GET /api/v1/channel_programs/:id' do
    it 'returns program with all fields and zero time_watched when no user' do
      get "/api/v1/channel_programs/#{program.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      
      expect(json['result']['id']).to eq(program.id)
      expect(json['result']['channel_id']).to eq(program.channel_id)
      expect(json['result']['schedule']).to be_a(String)
      expect(json['result']['created_at']).to be_present
      expect(json['result']['title']).to eq(program.content.original_name)
      expect(json['result']['year']).to eq(program.content.year)
      expect(json['result']['time_watched']).to eq(0)
    end

    it 'returns program with user specific time_watched' do
      user = create(:user)
      create(:most_watched, user: user, channel_program: program, time_overall: 1800)

      get "/api/v1/channel_programs/#{program.id}?user_id=#{user.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body
      
      expect(json['result']['id']).to eq(program.id)
      expect(json['result']['time_watched']).to eq(1800)
    end

    it 'returns 404 for non-existent program' do
      get '/api/v1/channel_programs/999'

      expect(response).to have_http_status(:not_found)
    end
  end
end
