# frozen_string_literal: true

class Content < ApplicationRecord
  belongs_to :contentable, polymorphic: true
  has_many :favorites, dependent: :destroy
  has_many :most_watched, dependent: :destroy
  has_many :users_who_favorited, through: :favorites, source: :user
  has_many :users_who_watched, through: :most_watched, source: :user

  validates :original_name, presence: true, length: { maximum: 255 }
  validates :contentable_type, presence: true, length: { maximum: 50 }
end
