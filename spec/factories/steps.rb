FactoryBot.define do
  factory :step do
    recipe_id { '1' }
    explanation { Faker::Lorem.characters(number: 30) }
  end
end
