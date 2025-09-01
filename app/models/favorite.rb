# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :content

  validates :user_id, uniqueness: { scope: :content_id }
end
