FactoryBot.define do
  factory :favorite do
    association                   :recipe
    association                   :user
  end
end
