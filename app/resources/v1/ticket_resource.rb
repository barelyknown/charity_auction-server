module V1
  class TicketResource < BaseResource
    attribute :price
    attribute :number
    has_one :auction
    has_one :user
    has_many :bidders

    class << self
      def creatable_fields(context)
        super - [:bidders]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
