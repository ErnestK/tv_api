# frozen_string_literal: true

class TvShowsSeason < ApplicationRecord
  belongs_to :tv_show
  has_one :content, as: :contentable, dependent: :destroy
  has_many :tv_shows_seasons_episodes, dependent: :destroy

  validates :number, presence: true, uniqueness: { scope: :tv_show_id }

  def self.create_with_content!(season_attrs, content_attrs)
    transaction do
      season = create!(season_attrs)
      season.create_content!(content_attrs)
      season
    end
  end
end
