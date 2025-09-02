# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::ChannelPrograms', type: :request do
  let(:program) { create(:channel_program) }

  describe 'GET /api/v1/channel_programs/:id' do
    it 'returns program with all fields and zero time_watched' do
      get "/api/v1/channel_programs/#{program.id}"

      expect(response).to have_http_status(:ok)
      json = response.parsed_body

      expect(json['result']['id']).to eq(program.id)
      expect(json['result']['channel_id']).to eq(program.channel_id)

      schedule = json['result']['schedule']
      expect(schedule).to be_present
      expect(schedule).to include(program.time_range.begin.strftime('%Y-%m-%d'))
      expect(schedule).to include(program.time_range.end.strftime('%Y-%m-%d'))

      expect(json['result']['created_at']).to be_present
      expect(json['result']['title']).to eq(program.content.original_name)
      expect(json['result']['year']).to eq(program.content.year)
    end

    it 'returns 404 for non-existent program' do
      get '/api/v1/channel_programs/999'

      expect(response).to have_http_status(:not_found)
    end
  end
end
