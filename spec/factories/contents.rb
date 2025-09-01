# frozen_string_literal: true

FactoryBot.define do
  factory :content do
    original_name { 'Sample Content' }
    contentable { build(:movie) }
  end
end
