module V1
  class AuctionItemResource < BaseResource
    has_one :auction

    has_one :donation

    has_one :bid_type

    has_one :bid_group

    class << self
      def creatable_fields(context)
        super
      end
      alias_method :updatable_fields, :creatable_fields
    end
  end
end
