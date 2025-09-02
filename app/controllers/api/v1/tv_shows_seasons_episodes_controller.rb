# frozen_string_literal: true

module Api
  module V1
    class TvShowsSeasonsEpisodesController < BaseController
      api :GET, '/tv_shows_seasons_episodes/:id', 'Get TV show episode details'
      param :id, :number, desc: 'Episode ID', required: true
      returns code: 200, desc: 'Success' do
        property :result, Hash, desc: 'Episode details with content information' do
          property :id, Integer, desc: 'Episode ID'
          property :tv_shows_season_id, Integer, desc: 'Parent Season ID'
          property :number, Integer, desc: 'Episode number'
          property :duration_in_seconds, Integer, desc: 'Episode duration in seconds'
          property :title, String, desc: 'Episode title'
          property :year, Integer, desc: 'Episode year'
          property :created_at, String, desc: 'Creation timestamp'
        end
      end
      returns code: 404, desc: 'Episode not found'
      def show
        @episode = TvShowsSeasonsEpisode.preload(:content).find(params[:id])
      end
    end
  end
end
