module V1
  class BidResource < BaseResource
    attribute :amount

    attribute :balance

    attribute :winner

    has_one :auction_item

    has_one :bidder

    has_many :bid_payments

    class << self
      def creatable_fields(context)
        super - [:bid_payments, :balance]
      end
      alias_method :updatable_fields, :creatable_fields
    end

  end
end
