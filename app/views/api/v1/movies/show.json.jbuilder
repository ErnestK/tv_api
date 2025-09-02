# frozen_string_literal: true

json.result do
  json.extract! @movie, :id, :duration_in_seconds, :created_at
  json.title @movie.content.original_name
  json.year @movie.content.year
end
