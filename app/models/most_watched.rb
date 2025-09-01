# frozen_string_literal: true

class MostWatched < ApplicationRecord
  belongs_to :user
  belongs_to :content

  validates :user_id, uniqueness: { scope: :content_id }
  validates :time_overall, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
