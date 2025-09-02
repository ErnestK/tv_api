# frozen_string_literal: true

module Api
  module V1
    class ChannelProgramsController < BaseController
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
