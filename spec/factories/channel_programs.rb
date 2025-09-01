# frozen_string_literal: true

FactoryBot.define do
  factory :channel_program do
    association :channel
    time_range { Time.current..1.hour.from_now }

    after(:create) do |program|
      create(:content, contentable: program)
    end
  end
end
