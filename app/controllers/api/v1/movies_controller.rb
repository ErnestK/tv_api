# frozen_string_literal: true

module Api
  module V1
    class MoviesController < BaseController
      def show
        @movie = Movie.preload(:content).find(params[:id])
      end
    end
  end
end
