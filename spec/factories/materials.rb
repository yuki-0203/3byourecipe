FactoryBot.define do
  factory :material do
    association                 :recipe
    name                        { Faker::Food }
    quantity                    { '１' }
  end
end
