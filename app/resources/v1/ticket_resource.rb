module V1
  class TicketResource < BaseResource
    attribute :price
    attribute :number
    attribute :create_bidder_automatically
    has_one :auction
    has_one :user
    has_many :bidders

    class << self
      def creatable_fields(context)
        super - [:bidders]
      end

      def updatable_fields(context)
        creatable_fields(context)
      end
    end

    def fetchable_fields
      super - [:create_bidder_automatically]
    end
  end
end
