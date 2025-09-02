# frozen_string_literal: true

json.result do
  json.extract! @tv_show, :id, :created_at
  json.title @tv_show.content.original_name
  json.year @tv_show.content.year
end
