FactoryBot.define do
  factory :step do
    association                 :recipe
    explanation                 { Faker::Lorem.characters(number: 30) }
  end
end
