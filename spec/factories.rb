require 'faker'

FactoryGirl.define do
  factory :license do
    state
    license_number { Faker::Crypto.md5 }
    license_type { [:processor, :producer, :retailer].sample }
  end
  factory :city do
    state
    name { Faker::Address.city }
  end
  factory :state do
    name { Faker::Address.state }
    abbreviation { Faker::Address.state_abbr }
  end
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
