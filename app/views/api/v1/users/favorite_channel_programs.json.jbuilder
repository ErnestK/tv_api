# frozen_string_literal: true

json.result do
  json.array! @programs do |most_watched|
    program = most_watched.channel_program

    json.extract! program, :id, :channel_id, :created_at, :updated_at
    json.schedule program.schedule
    json.title program.content.original_name
    json.year program.content.year
    json.time_watched most_watched.time_overall
  end
end
