# frozen_string_literal: true

class TvShow < ApplicationRecord
  include Contentable

  has_many :tv_shows_seasons, dependent: :destroy
end
