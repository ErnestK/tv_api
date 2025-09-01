# frozen_string_literal: true

class ChannelProgram < ApplicationRecord
  include Contentable

  belongs_to :channel

  validates :time_range, presence: true
end
