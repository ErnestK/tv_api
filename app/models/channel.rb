# frozen_string_literal: true

class Channel < ApplicationRecord
  include Contentable

  has_many :channel_programs, dependent: :destroy
end
