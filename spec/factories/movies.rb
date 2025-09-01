# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    duration_in_seconds { 7200 }

    after(:create) do |movie|
      create(:content, contentable: movie, year: 2023)
    end
  end
end
