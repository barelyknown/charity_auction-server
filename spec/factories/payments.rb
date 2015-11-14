FactoryGirl.define do
  factory :payment do
    bidder nil
    amount "9.99"
    payment_method "cash"
    association :auction, strategy: :build
  end
end
