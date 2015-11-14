module V1
  class AuctionItemResource < BaseResource
    attribute :minimum_bid_amount

    attribute :number

    has_one :auction

    has_one :donation

    has_one :bid_type

    has_one :bid_group

    has_many :bids

    class << self
      def creatable_fields(context)
        super - [:bids]
      end
      alias_method :updatable_fields, :creatable_fields
    end
  end
end
