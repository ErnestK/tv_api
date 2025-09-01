# frozen_string_literal: true

FactoryBot.define do
  factory :tv_show do
    year { 2020 }

    after(:create) do |tv_show|
      create(:content, contentable: tv_show)
    end
  end
end
