# frozen_string_literal: true

module Api
  module V1
    class ChannelProgramsController < BaseController
      def show
        @program = ChannelProgram.preload(:content).find(params[:id])
      end
    end
  end
end
