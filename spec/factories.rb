require 'faker'

FactoryGirl.define do
  factory :inventory_type do
    name { Faker::Lorem.word }
  end
  factory :note do
    description { Faker::Lorem.sentence }
    name { Faker::Lorem.word }
  end
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| "test#{n}@test.com" }
    password "testpass1234"
  end
end
