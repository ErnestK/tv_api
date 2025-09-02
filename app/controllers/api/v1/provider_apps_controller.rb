# frozen_string_literal: true

module Api
  module V1
    class ProviderAppsController < BaseController
      def show
        @provider_app = ProviderApp.preload(:content).find(params[:id])
      end
    end
  end
end
