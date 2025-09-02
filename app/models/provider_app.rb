# frozen_string_literal: true

class ProviderApp < ApplicationRecord
  self.table_name = 'provider_apps'

  include Contentable

  has_many :availability, dependent: :destroy
  has_many :available_contents, through: :availability, source: :content
end
