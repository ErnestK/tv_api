# frozen_string_literal: true

class User < ApplicationRecord
  has_many :favorites, dependent: :destroy
  has_many :most_watched, dependent: :destroy
  has_many :favorite_contents, through: :favorites, source: :content
  has_many :watched_contents, through: :most_watched, source: :content

  validates :name, presence: true, length: { maximum: 255 }
end
