# frozen_string_literal: true

json.result do
  json.extract! @episode, :id, :tv_shows_season_id, :number, :duration_in_seconds, :created_at
  json.title @episode.content.original_name
  json.year @episode.content.year
end
