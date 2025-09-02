# frozen_string_literal: true

json.result do
  json.array! @favorite_provider_apps do |favorite|
    provider_app = favorite.provider_app

    json.extract! provider_app, :id, :created_at
    json.name provider_app.content.original_name
    json.year provider_app.content.year
    json.position favorite.order_num
  end
end
