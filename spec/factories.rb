require 'factory_girl'
require 'ffaker'

FactoryGirl.define do
  factory :idea do
    name FFaker::Product.product
    user
  end

  factory :user do
    email                 FFaker::Internet.email
    name                  FFaker::Name.name
    password              FFaker::Internet.password

    after(:build) do |user|
      user.password_confirmation = user.password
    end
  end

end
