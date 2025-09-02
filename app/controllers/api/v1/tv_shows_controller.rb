# frozen_string_literal: true

module Api
  module V1
    class TvShowsController < BaseController
      def show
        @tv_show = TvShow.preload(:content).find(params[:id])
      end
    end
  end
end
