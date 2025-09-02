# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      before_action :set_default_format

      rescue_from StandardError, with: :render_internal_error
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      private

      def set_default_format
        request.format = :json
      end

      def render_not_found(exception)
        render json: {
          error: 'Not Found',
          message: 'Row not exist'
        }, status: :not_found
      end

      def render_internal_error(exception)
        Rails.logger.error "Internal Error: #{exception.message}"
        Rails.logger.error exception.backtrace.join("\n")

        render json: {
          error: 'Internal Server Error',
          message: 'Something went wrong'
        }, status: :internal_server_error
      end
    end
  end
end
