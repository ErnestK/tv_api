# frozen_string_literal: true

json.result do
  json.extract! @provider_app, :id, :created_at
  json.name @provider_app.content.original_name
  json.year @provider_app.content.year
end
