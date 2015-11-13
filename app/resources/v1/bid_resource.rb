module V1
  class BidResource < BaseResource
    attribute :amount

    attribute :winner

    has_one :auction_item

    has_one :bidder

    class << self
      def creatable_fields(context)
        super
      end
      alias_method :updatable_fields, :creatable_fields
    end
  end
end
