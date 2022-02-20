FactoryBot.define do
  factory :recipe do
    user_id                    { Faker::Name }
    name                   { Faker::Name }
    introduction                 { "01234567890" }
    serving                    { "man" }
    note                        { Faker::Internet.email }
    image_id                     { Faker::Alphanumeric}
    steps_count                     { Faker::Name }
  end
end