# frozen_string_literal: true

json.result do
  json.array! @contents do |content|
    json.extract! content, :original_name, :year, :created_at

    json.content do
      json.id content.contentable.id
      json.type content.contentable_type
    end
  end
end 