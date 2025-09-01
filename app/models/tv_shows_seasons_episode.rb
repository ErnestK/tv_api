# frozen_string_literal: true

class TvShowsSeasonsEpisode < ApplicationRecord
  belongs_to :tv_shows_season
  has_one :content, as: :contentable, dependent: :destroy

  validates :number, presence: true, uniqueness: { scope: :tv_shows_season_id }

  def self.create_with_content!(episode_attrs, content_attrs)
    transaction do
      episode = create!(episode_attrs)
      episode.create_content!(content_attrs)
      episode
    end
  end
end
