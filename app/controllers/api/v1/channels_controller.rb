# frozen_string_literal: true

module Api
  module V1
    class ChannelsController < BaseController
      def show
        @channel = Channel.preload(:content).find(params[:id])
      end
    end
  end
end
