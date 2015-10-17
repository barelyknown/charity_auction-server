module V1
  class DonationResource < BaseResource
    attribute :title
    attribute :description
    attribute :quantity
    attribute :redemption_window_starts_at
    attribute :redemption_window_ends_at
    attribute :estimated_value_amount
    attribute :minimum_bid_amount
    attribute :display_description
    attribute :admin_follow_up_needed
    attribute :fulfillment_type
    has_one :bid_type
    has_one :auction
    has_one :donor
  end
end
