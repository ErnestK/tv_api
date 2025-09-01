# frozen_string_literal: true

class TvShowsSeason < ApplicationRecord
  include Contentable

  belongs_to :tv_show
  has_many :tv_shows_seasons_episodes, dependent: :destroy

  validates :number, presence: true, uniqueness: { scope: :tv_show_id }
end
