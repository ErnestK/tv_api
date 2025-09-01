# frozen_string_literal: true

class Channel < ApplicationRecord
  has_one :content, as: :contentable, dependent: :destroy
  has_many :channel_programs, dependent: :destroy

  def self.create_with_content!(channel_attrs, content_attrs)
    transaction do
      channel = create!(channel_attrs)
      channel.create_content!(content_attrs)
      channel
    end
  end
end
