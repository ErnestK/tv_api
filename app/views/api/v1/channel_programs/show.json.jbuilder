# frozen_string_literal: true

json.result do
  json.extract! @program, :id, :channel_id, :created_at
  json.schedule @program.time_range
  json.title @program.content.original_name
  json.year @program.content.year
end
