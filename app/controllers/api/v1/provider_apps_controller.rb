# frozen_string_literal: true

module Api
  module V1
    class ProviderAppsController < BaseController
      api :GET, '/provider_apps/:id', 'Get provider app details'
      param :id, :number, desc: 'Provider App ID', required: true
      returns code: 200, desc: 'Success' do
        property :result, Hash, desc: 'Provider app details with content information' do
          property :id, Integer, desc: 'Provider App ID'
          property :name, String, desc: 'App name'
          property :year, Integer, desc: 'App release year'
          property :created_at, String, desc: 'Creation timestamp'
        end
      end
      returns code: 404, desc: 'Provider App not found'
      def show
        @provider_app = ProviderApp.preload(:content).find(params[:id])
        render json: {
          result: {
            id: @provider_app.id,
            created_at: @provider_app.created_at,
            name: @provider_app.content.original_name,
            year: @provider_app.content.year
          }
        }
      end
    end
  end
end
