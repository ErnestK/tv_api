# frozen_string_literal: true

class App < ApplicationRecord
  has_one :content, as: :contentable, dependent: :destroy

  def self.create_with_content!(app_attrs, content_attrs)
    transaction do
      app = create!(app_attrs)
      app.create_content!(content_attrs)
      app
    end
  end
end
