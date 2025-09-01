# frozen_string_literal: true

class TvShow < ApplicationRecord
  has_one :content, as: :contentable, dependent: :destroy
  has_many :tv_shows_seasons, dependent: :destroy

  def self.create_with_content!(tv_show_attrs, content_attrs)
    transaction do
      tv_show = create!(tv_show_attrs)
      tv_show.create_content!(content_attrs)
      tv_show
    end
  end
end
