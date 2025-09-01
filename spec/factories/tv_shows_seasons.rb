# frozen_string_literal: true

FactoryBot.define do
  factory :tv_shows_season do
    association :tv_show
    number { 1 }
    year { 2020 }

    after(:create) do |season|
      create(:content, contentable: season)
    end
  end
end
