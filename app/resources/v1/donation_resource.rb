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
    attribute :fulfillment_type
    attribute :notes
    has_one :bid_type
    has_one :auction
    has_one :bid_group
    has_one :donation_category
    has_many :donation_donors

    class << self
      def creatable_fields(context)
        super - [:donation_donors]
      end

      alias_method :updatable_fields, :creatable_fields
    end

  end
end
