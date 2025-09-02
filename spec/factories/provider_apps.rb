# frozen_string_literal: true

FactoryBot.define do
  factory :provider_app do
    after(:create) do |provider_app|
      create(:content, contentable: provider_app)
    end
  end
end
