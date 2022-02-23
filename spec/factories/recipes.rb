FactoryBot.define do
  factory :recipe do
    user_id { '1' }
    name { 'うどん' }
    introduction { '簡単で美味しいうどんです！' }
    serving { '1' }
    note { '鰹節をトッピングしても美味しいです！' }
    image_id { Faker::Lorem.characters(number: 20) }
    steps_count { '2' }

    after(:build) do |recipe|
      recipe.materials << FactoryBot.build(:material, recipe_id: recipe.id)
      recipe.steps << FactoryBot.build(:step, recipe_id: recipe.id)
    end
  end
end
