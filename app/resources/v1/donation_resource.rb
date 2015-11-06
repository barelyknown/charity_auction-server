module V1
  class DonationResource < BaseResource
    attribute :title
    attribute :description
    attribute :quantity
    attribute :redemption_window_starts_at
    attribute :redemption_window_ends_at
    attribute :estimated_value_amount
    attribute :display_description
    attribute :fulfillment_type
    attribute :notes
    has_one :auction
    has_one :auction_item
    has_one :donation_category
    has_many :donation_donors

    def auction_item_id
      auction_item.try(:id)
    end

    class << self
      def creatable_fields(context)
        super - [:donation_donors, :auction_item]
      end

      alias_method :updatable_fields, :creatable_fields
    end

  end
end
