# frozen_string_literal: true

class Availability < ApplicationRecord
  belongs_to :content
  belongs_to :app
  belongs_to :country

  validates :content_id, uniqueness: { scope: %i[app_id country_id] }
end
