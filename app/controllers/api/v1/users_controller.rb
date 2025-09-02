# frozen_string_literal: true

module Api
  module V1
    class UsersController < BaseController
      before_action :set_user

      api :GET, '/users/:id/favorite_channel_programs', 'Get user favorite channel programs ordered by time watched'
      param :id, :number, desc: 'User ID', required: true
      returns code: 200, desc: 'Success' do
        property :result, Array, desc: 'Array of favorite channel programs ordered by time watched (desc)'
      end
      returns code: 404, desc: 'User not found'
      def favorite_channel_programs
        @programs = @user.most_watched
                         .preload(channel_program: :content)
                         .order(time_overall: :desc)
      end

      api :GET, '/users/:id/favorite_provider_apps', 'Get user favorite provider apps ordered by position'
      param :id, :number, desc: 'User ID', required: true
      returns code: 200, desc: 'Success' do
        property :result, Array, desc: 'Array of favorite provider apps ordered by position'
      end
      returns code: 404, desc: 'User not found'
      def favorite_provider_apps
        @favorite_provider_apps = @user.favorites
                                       .preload(provider_app: :content)
                                       .order(:order_num)
      end

      api :POST, '/users/:id/favorite_provider_app', 'Add provider app to user favorites with position'
      param :id, :number, desc: 'User ID', required: true
      param :favorite, Hash, desc: 'Favorite data', required: true do
        param :provider_app_id, :number, desc: 'Provider app ID', required: true
        param :order_num, :number, desc: 'Position in favorites list (unique per user)', required: true
      end
      returns code: 201, desc: 'Successfully added to favorites'
      returns code: 400, desc: 'Validation failed'
      returns code: 404, desc: 'User not found'
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
