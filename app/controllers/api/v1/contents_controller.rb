# frozen_string_literal: true

module Api
  module V1
    class ContentsController < BaseController
      def index
        @contents = Content.joins(:availability)
                           .where(availability: { country: country })
                           .preload(:contentable)
                           .distinct

        @contents = @contents.where(contentable_type: content_type) if content_type.present?
      end

      private

      def country
        country_code = params[:country]
        raise ArgumentError, 'Country parameter is required' if country_code.blank?

        @country ||= Country.find_by!(code: country_code.upcase)
      end

      def content_type
        return nil if params[:type].blank?

        requested_type = params[:type].camelize
        available_types = Content.contentable_classes

        unless available_types.include?(requested_type)
          raise ArgumentError,
                "Invalid content type: #{params[:type]}. Available types: #{available_types.map(&:underscore).join(', ')}"
        end

        requested_type
      end
    end
  end
end
