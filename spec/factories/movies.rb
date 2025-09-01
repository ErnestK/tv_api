# frozen_string_literal: true

FactoryBot.define do
  factory :movie do
    year { 2023 }
    duration_in_seconds { 7200 }
  end

  factory :movie_with_content, parent: :movie do
    after(:create) do |movie|
      create(:content, contentable: movie)
    end
  end
end
