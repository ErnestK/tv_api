# frozen_string_literal: true

FactoryBot.define do
  factory :app do
    after(:create) do |app|
      create(:content, contentable: app)
    end
  end
end
