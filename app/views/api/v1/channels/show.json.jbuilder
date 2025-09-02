# frozen_string_literal: true

json.result do
  json.extract! @channel, :id, :created_at
  json.title @channel.content.original_name
  json.year @channel.content.year
end
