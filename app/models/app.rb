# frozen_string_literal: true

class App < ApplicationRecord
  include Contentable

  has_many :availability, dependent: :destroy
  has_many :available_contents, through: :availability, source: :content
end
