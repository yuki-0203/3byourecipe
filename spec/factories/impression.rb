FactoryBot.define do
  factory :impression do
    association                   :recipe
    user                          { recipe.user }
    impression                    { '5分で作れちゃいました！とってもおいしかったです！' }
    image_id { Faker::Lorem.characters(number: 20) }
  end
end
