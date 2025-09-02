# frozen_string_literal: true

FactoryBot.define do
  factory :most_watched do
    association :user
    association :channel_program
    time_overall { 3600 }
  end
end
