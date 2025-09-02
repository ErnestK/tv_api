# frozen_string_literal: true

module Api
  module V1
    class ChannelProgramsController < BaseController
      api :GET, '/channel_programs/:id', 'Get channel program details with optional time watched'
      param :id, :number, desc: 'Channel program ID', required: true
      param :user_id, :number, desc: 'User ID to get personalized time watched (optional)', required: false
      returns code: 200, desc: 'Success' do
        property :result, Hash, desc: 'Channel program details' do
          property :id, Integer, desc: 'Program ID'
          property :channel_id, Integer, desc: 'Channel ID'
          property :schedule, Array, desc: 'Array of time ranges when program airs'
          property :title, String, desc: 'Program title'
          property :year, Integer, desc: 'Program year'
          property :time_watched, Integer, desc: 'Time watched by user in seconds (0 if no user_id)'
          property :created_at, String, desc: 'Creation timestamp'
        end
      end
      returns code: 404, desc: 'Channel program not found'
      def show
        @program = ChannelProgram.preload(:content).find(params[:id])

        @time_watched = if params[:user_id]
                          MostWatched.find_by(user_id: params[:user_id], channel_program: @program)&.time_overall || 0
                        else
                          0
                        end
      end
    end
  end
end
