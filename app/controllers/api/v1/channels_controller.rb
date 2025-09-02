# frozen_string_literal: true

module Api
  module V1
    class ChannelsController < BaseController
      api :GET, '/channels/:id', 'Get channel details'
      param :id, :number, desc: 'Channel ID', required: true
      returns code: 200, desc: 'Success' do
        property :result, Hash, desc: 'Channel details with content information' do
          property :id, Integer, desc: 'Channel ID'
          property :title, String, desc: 'Channel title'
          property :year, Integer, desc: 'Channel year'
          property :created_at, String, desc: 'Creation timestamp'
        end
      end
      returns code: 404, desc: 'Channel not found'
      def show
        @channel = Channel.preload(:content).find(params[:id])
      end
    end
  end
end
