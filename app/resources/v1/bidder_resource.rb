module V1
  class BidderResource < BaseResource
    attribute :number
    has_one :auction
    has_many :tickets, acts_as_set: true
    has_many :payments
    has_many :bids

    class << self
      def creatable_fields(context)
        super - [:payments, :bids]
      end
      alias_method :updatable_fields, :creatable_fields
    end
  end
end
