class Content < ApplicationRecord
  belongs_to :contentable, polymorphic: true

  validates :original_name, presence: true, length: { maximum: 255 }
  validates :contentable_type, presence: true, length: { maximum: 50 }
  validates :contentable_id, presence: true
end 