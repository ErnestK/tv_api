# frozen_string_literal: true

class ChannelProgram < ApplicationRecord
  include Contentable

  belongs_to :channel
  has_many :most_watched, dependent: :destroy
  has_many :users_who_watched, through: :most_watched, source: :user

  validates :time_range, presence: true
end
