require 'factory_girl'
require 'ffaker'

FactoryGirl.define do
  factory :idea do
    name FFaker::Product.product
    user
  end

  factory :user do
    sequence(:email) { |n| "user-#{n}@example.com" }
    name             FFaker::Name.name
    password         FFaker::Internet.password

    after(:build) do |user|
      user.password_confirmation = user.password
    end
  end

end
