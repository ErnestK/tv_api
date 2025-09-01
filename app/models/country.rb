# frozen_string_literal: true

class Country < ApplicationRecord
  has_many :availability, dependent: :destroy
  has_many :contents, through: :availability

  validates :name, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :code, presence: true, length: { maximum: 5 }
end
