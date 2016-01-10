require 'factory_girl'
require 'ffaker'

FactoryGirl.define do
  factory :channel do
    name FFaker::Product.product
  end

  factory :comment do
    body FFaker::Lorem.paragraph
    idea
    user
  end

  factory :crowdfunding_option do
    name FFaker::Product.product
  end

  factory :financial_entry do
    name  FFaker::Product.product
    group FinancialEntry::GROUP_ASSETS
    sequence(:value)
    idea
  end

  factory :founder do
    idea
    user
  end

  factory :idea do
    name FFaker::Product.product
    user
  end

  factory :problem do
    description FFaker::Lorem.paragraph
    idea
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
