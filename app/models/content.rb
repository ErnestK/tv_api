# frozen_string_literal: true

class Content < ApplicationRecord
  belongs_to :contentable, polymorphic: true
  has_many :favorites, dependent: :destroy
  has_many :most_watched, dependent: :destroy
  has_many :availability, dependent: :destroy
  has_many :users_who_favorited, through: :favorites, source: :user
  has_many :users_who_watched, through: :most_watched, source: :user
  has_many :available_countries, through: :availability, source: :country

  validates :original_name, presence: true, length: { maximum: 255 }
  validates :contentable_type, presence: true, length: { maximum: 50 }

  scope :search, lambda { |query|
    return all if query.blank?

    search_sql = "to_tsvector('english', coalesce(original_name, '') || ' ' || " \
                 "coalesce(year::text, '')) @@ plainto_tsquery('english', ?)"
    where(search_sql, query)
  }
end
