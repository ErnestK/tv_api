# frozen_string_literal: true

FactoryBot.define do
  factory :channel do
    after(:create) do |channel|
      create(:content, contentable: channel)
    end
  end
end
