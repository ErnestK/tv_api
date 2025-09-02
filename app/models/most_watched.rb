# frozen_string_literal: true

class MostWatched < ApplicationRecord
  belongs_to :user
  belongs_to :channel_program

  validates :user_id, uniqueness: { scope: :channel_program_id }
  validates :time_overall, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
