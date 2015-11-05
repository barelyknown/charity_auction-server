module V1
  class BidGroupResource < BaseResource
    has_one :auction
    has_many :auction_items
    attribute :name
    attribute :description
    attribute :sequence_position
    attribute :sequence

    class << self
      def creatable_fields(context)
        super - [:auction_items]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
