require 'faker'

FactoryGirl.define do
  factory :user do
    name "John Doe"
    sequence(:email) { |n| "test#{n}@test.com" }
    password "testpass1234"
  end
end
