FactoryBot.define do
  factory :user do
    last_name                    { Faker::Name }
    first_name                   { Faker::Name }
    phone_number                 { "01234567890" }
    is_gender                    { "man" }
    email                        { Faker::Internet.email }
    password                     { Faker::Alphanumeric}
    nickname                     { Faker::Name }
    introduction                 { Faker::Lorem.characters(number: 20) }
  end
end