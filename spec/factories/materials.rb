FactoryBot.define do
  factory :material do
    recipe_id                      { "1" }
    name                        { Faker::Food }
    quantity                    { "１" }
  end
end