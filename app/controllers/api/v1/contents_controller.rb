# frozen_string_literal: true

module Api
  module V1
    class ContentsController < BaseController
      api :GET, '/contents', 'Get filtered content by country and type'
      param :country, String, desc: 'Country code (required)', required: true
      param :type, String,
            desc: 'Content type filter (optional). Available: movie, tv_show, channel, provider_app, etc.'
      returns code: 200, desc: 'Success' do
        property :result, Array, desc: 'Array of content items'
      end
      returns code: 400, desc: 'Bad Request - Invalid parameters'
      returns code: 404, desc: 'Not Found - Invalid country'
      def index
        @contents = Content.joins(:availability)
                           .where(availability: { country: country })
                           .preload(:contentable)
                           .distinct

        @contents = @contents.where(contentable_type: content_type) if content_type.present?
      end

      api :GET, '/contents/search', 'Search content by title or year'
      param :q, String, desc: 'Search query (title, year, or partial text)', required: true
      returns code: 200, desc: 'Success' do
        property :result, Array, desc: 'Array of matching content items'
      end
      returns code: 400, desc: 'Bad Request - Missing query parameter'
      def search
        query = params.require(:q)
        @contents = Content.search(query).preload(:contentable)
      end

      private

      def country
        country_code = params.require(:country)
        @country ||= Country.find_by!(code: country_code.upcase)
      end

      def content_type
        return nil if params[:type].blank?

        requested_type = params[:type].camelize
        available_types = Content.contentable_classes

        unless available_types.include?(requested_type)
          available_list = available_types.map(&:underscore).join(', ')
          raise ArgumentError, "Invalid content type: #{params[:type]}. Available types: #{available_list}"
        end

        requested_type
      end
    end
  end
end
