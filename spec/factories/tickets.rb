FactoryGirl.define do
  factory :ticket do
    association :user, strategy: :build
    price "9.99"
    association :auction, strategy: :build
    sequence(:number) { |n| n.to_s }
  end

end
