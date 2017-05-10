require 'faker'

FactoryGirl.define do
  factory :growing_medium do
    room_section
    medium_type { GrowingMedium.medium_types.keys.sample }
    name { Faker::Ancient.god }
    barcode { Faker::Code.ean }
    quantity 2
  end
  factory :room_section do
    name { Faker::Ancient.hero }
    area_in_inches 10_000
    section_type { RoomSection.section_types.keys.sample }
    is_growing_space { [true, false].sample }
    room
  end
  factory :room do
    location
    room_type { [:office, :inventory, :additive, :mother, :seedling, :clone, :veg, :pre_flower, :flower, :harvest].sample }
    name { Faker::GameOfThrones.house }
    area_in_inches 20_000
    is_growing_space { [true, false].sample }
  end
  factory :patient do
    physician
    city
    name { Faker::Name.name }
    street_address { Faker::Address.street_address }
    is_medical { [true, false].sample }
  end
  factory :physician do
    name { Faker::Name.name }
    license_number { Faker::Crypto.md5 }
  end
  factory :growing_stage do
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    license
  end
  factory :strain do
    name { Faker::GameOfThrones.character }
    expected_potency 28.4
    expected_yield 400
    veg_days 40
    flower_days 70
  end
  factory :location do
    license
    city
    name { Faker::Company.name }
    street_address { Faker::Address.street_address }
    phone_number { Faker::PhoneNumber.phone_number }
    area_in_inches 100_000
  end
  factory :vehicle do
    license
    vin { Faker::Vehicle.vin }
    make "Subaru"
    model "Outback"
    year 2000
    color "black"
  end
  factory :regulation do
    legal_reference_code "1a.11"
    description { Faker::Lorem.sentence }
  end
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
