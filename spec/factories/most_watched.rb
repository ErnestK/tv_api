# frozen_string_literal: true

FactoryBot.define do
  factory :most_watched do
    association :user
    content { create(:movie).content }
    time_overall { 3600 }
  end
end
