FactoryBot.define do
  factory :user do
    last_name                    { Faker::Name }
    first_name                   { Faker::Name }
    phone_number                 { "0#{rand(0..9)}0#{rand(1_000_000..99_999_999)}" }
    is_gender                    { 'man' }
    email                        { Faker::Internet.email }
    password                     { Faker::Alphanumeric }
    nickname                     { "名無し" }
    introduction                 { Faker::Lorem.characters(number: 20) }
  end
end
