# frozen_string_literal: true

module Api
  module V1
    class MoviesController < BaseController
      api :GET, '/movies/:id', 'Get movie details'
      param :id, :number, desc: 'Movie ID', required: true
      returns code: 200, desc: 'Success' do
        property :result, Hash, desc: 'Movie details with content information' do
          property :id, Integer, desc: 'Movie ID'
          property :duration_in_seconds, Integer, desc: 'Movie duration in seconds'
          property :title, String, desc: 'Movie title'
          property :year, Integer, desc: 'Release year'
          property :created_at, String, desc: 'Creation timestamp'
          property :updated_at, String, desc: 'Update timestamp'
        end
      end
      returns code: 404, desc: 'Movie not found'
      def show
        @movie = Movie.preload(:content).find(params[:id])
      end
    end
  end
end
