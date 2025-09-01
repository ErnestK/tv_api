FactoryBot.define do
  factory :content do
    original_name { "Sample Content" }
    
    trait :for_movie do
      association :contentable, factory: :movie
    end

    contentable { association(:movie) }
  end
end 