FactoryGirl.define do
  factory :user do
    name "Sean Devine"
    password "12344321"
    sequence(:mobile_phone_number) { |n| "+1888555121#{n}" }
    sequence(:email_address) { |n| "test-#{n}@test.com" }
    physical_address "123 Main St\nAnytown, NY 12121 USA"
  end
end
