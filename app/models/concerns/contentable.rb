# frozen_string_literal: true

module Contentable
  extend ActiveSupport::Concern

  included do
    has_one :content, as: :contentable, dependent: :destroy
  end

  class_methods do
    def create_with_content!(model_attrs, content_attrs)
      transaction do
        model = create!(model_attrs)
        model.create_content!(content_attrs)
        model
      end
    end
  end
end
