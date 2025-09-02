# frozen_string_literal: true

class ProviderApp < ApplicationRecord
  include Contentable

  has_many :availability, dependent: :destroy
  has_many :available_contents, through: :availability, source: :content
  has_many :favorites, dependent: :destroy
  has_many :users_who_favorited, through: :favorites, source: :user
end
