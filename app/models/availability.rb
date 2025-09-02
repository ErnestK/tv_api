# frozen_string_literal: true

class Availability < ApplicationRecord
  belongs_to :content
  belongs_to :provider_app
  belongs_to :country

  validates :content_id, uniqueness: { scope: %i[provider_app_id country_id] }
end
