FactoryGirl.define do
  factory :auction do
    association :organization, strategy: :build
    starts_at "2015-10-09 08:47:47"
    ends_at "2015-10-09 09:47:47"
    time_zone_id "America/New_York"
    physical_address "123 Main St\nAnytown, NY 21201 USA"
    name "2016 Charity Auction"
    donation_window_ends_at "2015-10-08 08:47:47"
  end
end
