FactoryGirl.define do
  factory :donor do
    association :user, strategy: :build
    association :auction, strategy: :build
  end
end
