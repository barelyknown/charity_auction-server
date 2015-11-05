FactoryGirl.define do
  factory :bid_group do
    association :auction, strategy: :build
    name "Group 1"
    description "Group 1 description"
  end
end
