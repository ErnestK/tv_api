# frozen_string_literal: true

module Api
  module V1
    class TvShowsSeasonsController < BaseController
      api :GET, '/tv_shows_seasons/:id', 'Get TV show season details'
      param :id, :number, desc: 'Season ID', required: true
      returns code: 200, desc: 'Success' do
        property :result, Hash, desc: 'Season details with content information' do
          property :id, Integer, desc: 'Season ID'
          property :tv_show_id, Integer, desc: 'Parent TV Show ID'
          property :number, Integer, desc: 'Season number'
          property :title, String, desc: 'Season title'
          property :year, Integer, desc: 'Season year'
          property :created_at, String, desc: 'Creation timestamp'
        end
      end
      returns code: 404, desc: 'Season not found'
      def show
        @season = TvShowsSeason.preload(:content).find(params[:id])
      end
    end
  end
end
