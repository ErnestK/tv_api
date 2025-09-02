# frozen_string_literal: true

FactoryBot.define do
  factory :favorite do
    association :user
    association :provider_app
    order_num { 1 }
  end
end
