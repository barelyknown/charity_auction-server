FactoryGirl.define do
  factory :donation do
    title "MyString"
description "MyText"
quantity 1
auction nil
bid_type nil
donor nil
redemption_window_starts_at "2015-10-10 22:43:45"
redemption_window_ends_at "2015-10-10 22:43:45"
estimated_value_dollars 1
minimum_bid_dollars 1
display_description "MyText"
admin_follow_up_needed false
item_number "MyString"
fulfillment_type 1
  end

end
