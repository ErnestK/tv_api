# frozen_string_literal: true

module Api
  module V1
    class TvShowsSeasonsEpisodesController < BaseController
      def show
        @episode = TvShowsSeasonsEpisode.preload(:content).find(params[:id])
      end
    end
  end
end
