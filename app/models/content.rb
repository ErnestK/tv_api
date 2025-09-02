# frozen_string_literal: true

class Content < ApplicationRecord
  belongs_to :contentable, polymorphic: true
  has_many :availability, dependent: :destroy
  has_many :available_countries, through: :availability, source: :country

  validates :original_name, presence: true, length: { maximum: 255 }
  validates :contentable_type, presence: true, length: { maximum: 50 }

  scope :search, lambda { |query|
    return all if query.blank?

    normalized_query = normalize_search_query(query)
    prefix_sql = "to_tsvector('english', coalesce(original_name, '') || ' ' || " \
                 "coalesce(year::text, '')) @@ to_tsquery('english', ?)"
    where(prefix_sql, normalized_query)
  }

  # Normalize query for prefix search: "foo bar" => "foo:* & bar:*"
  def self.normalize_search_query(query_str)
    query = query_str.split(/[@[:space:]]+/)
    query.compact_blank!
    query.map { |str| "#{str}:*" }.join(' & ')
  end

  def self.contentable_classes
    @contentable_classes ||= begin
      Rails.application.eager_load!
      ActiveRecord::Base.descendants
                        .select { |klass| klass.include?(Contentable) }
                        .map(&:name)
    end
  end
end
