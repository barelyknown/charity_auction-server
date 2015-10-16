FactoryGirl.define do
  factory :membership do
    association :user, strategy: :build
    association :organization, strategy: :build
  end
end
