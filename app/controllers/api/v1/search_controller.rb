# frozen_string_literal: true

module Api
  module V1
    class SearchController < BaseController
      def index
        query = params[:q]
        raise ArgumentError, 'Search query (q) parameter is required' if query.blank?

        @results = Content.search(query).preload(:contentable)
      end
    end
  end
end
