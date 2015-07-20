require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
    first_name 'rovaira'
    last_name 'dasig'
    class_year '2009'
  end
end
