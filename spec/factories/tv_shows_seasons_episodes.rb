# frozen_string_literal: true

FactoryBot.define do
  factory :tv_shows_seasons_episode do
    association :tv_shows_season
    number { 1 }
    duration_in_seconds { 2400 }

    after(:create) do |episode|
      create(:content, contentable: episode, year: 2020)
    end
  end
end
