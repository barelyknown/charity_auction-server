FactoryGirl.define do
  factory :auction_admin do
    association :user, strategy: :build
    association :auction, strategy: :build
  end
end
