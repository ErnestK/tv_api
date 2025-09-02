# frozen_string_literal: true

json.result do
  json.array! @contents do |content|
    json.extract! content, :original_name, :year, :contentable_type, :created_at

    json.content_id content.contentable.id
  end
end
