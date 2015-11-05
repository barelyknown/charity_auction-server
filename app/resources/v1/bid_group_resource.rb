module V1
  class BidGroupResource < BaseResource
    has_one :auction
    has_one :bid_type
    has_many :donations
    attribute :name
    attribute :description
    attribute :sequence_position
    attribute :sequence

    class << self
      def creatable_fields(context)
        super - [:donations]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
