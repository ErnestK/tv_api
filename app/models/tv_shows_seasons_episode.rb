# frozen_string_literal: true

class TvShowsSeasonsEpisode < ApplicationRecord
  include Contentable

  belongs_to :tv_shows_season

  validates :number, presence: true, uniqueness: { scope: :tv_shows_season_id }
end
