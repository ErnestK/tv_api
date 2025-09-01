# frozen_string_literal: true

class ChannelProgram < ApplicationRecord
  belongs_to :channel
  has_one :content, as: :contentable, dependent: :destroy

  validates :time_range, presence: true

  def self.create_with_content!(program_attrs, content_attrs)
    transaction do
      program = create!(program_attrs)
      program.create_content!(content_attrs)
      program
    end
  end
end
