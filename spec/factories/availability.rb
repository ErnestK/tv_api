# frozen_string_literal: true

FactoryBot.define do
  factory :availability do
    content { create(:movie).content }
    association :app
    association :country
  end
end
