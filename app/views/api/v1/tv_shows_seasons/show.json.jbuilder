# frozen_string_literal: true

json.result do
  json.extract! @season, :id, :tv_show_id, :number, :created_at
  json.title @season.content.original_name
  json.year @season.content.year
end
