# frozen_string_literal: true

module Api
  module V1
    class TvShowsController < BaseController
      api :GET, '/tv_shows/:id', 'Get TV show details'
      param :id, :number, desc: 'TV Show ID', required: true
      returns code: 200, desc: 'Success' do
        property :result, Hash, desc: 'TV show details with content information' do
          property :id, Integer, desc: 'TV Show ID'
          property :title, String, desc: 'TV Show title'
          property :year, Integer, desc: 'Release year'
          property :created_at, String, desc: 'Creation timestamp'
        end
      end
      returns code: 404, desc: 'TV Show not found'
      def show
        @tv_show = TvShow.preload(:content).find(params[:id])
      end
    end
  end
end
