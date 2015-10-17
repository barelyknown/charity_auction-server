module V1
  class BidTypeResource < BaseResource
    attribute :name

    class << self
      def creatable_fields(context)
        []
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
