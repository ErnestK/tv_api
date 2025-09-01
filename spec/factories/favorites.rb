# frozen_string_literal: true

FactoryBot.define do
  factory :favorite do
    association :user
    content { create(:movie).content }
  end
end
