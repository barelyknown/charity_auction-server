module V1
  class BidTypeResource < BaseResource
    attribute :name

    has_many :bid_groups

    has_many :donations

    class << self
      def creatable_fields(context)
        []
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
