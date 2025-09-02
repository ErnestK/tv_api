# frozen_string_literal: true

class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :most_watched, dependent: :destroy
  has_many :favorite_provider_apps, through: :favorites, source: :provider_app
  has_many :watched_channel_programs, through: :most_watched, source: :channel_program

  validates :name, presence: true, length: { maximum: 255 }
end
