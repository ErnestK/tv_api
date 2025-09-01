# frozen_string_literal: true

FactoryBot.define do
  factory :tv_show do
    after(:create) do |tv_show|
      create(:content, contentable: tv_show, year: 2020)
    end
  end
end
