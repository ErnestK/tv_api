# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      before_action :set_user

      # GET /api/v1/users/:id/favorite_channel_programs
      def favorite_channel_programs
        @programs = @user.most_watched
                         .preload(channel_program: :content)
                         .order(time_overall: :desc)
      end

      # GET /api/v1/users/:id/favorite_provider_apps
      def favorite_provider_apps
        @favorite_provider_apps = @user.favorites
                                       .preload(provider_app: :content)
                                       .order(:order_num)
      end

      # POST /api/v1/users/:id/favorite_provider_app
      def favorite_provider_app
        @favorite = @user.favorites.build(favorite_params)

        if @favorite.save
          render json: { result: { message: 'Provider app favorited successfully' } }, status: :created
        else
          render json: { error: 'Validation failed', message: @favorite.errors.full_messages },
                 status: :unprocessable_content
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def favorite_params
        params.require(:favorite).permit(:provider_app_id, :order_num)
      end
    end
  end
end
