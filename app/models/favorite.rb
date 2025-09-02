# frozen_string_literal: true

class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :provider_app

  validates :user_id, uniqueness: { scope: :provider_app_id }
  validates :order_num, presence: true, uniqueness: { scope: :user_id }
end
