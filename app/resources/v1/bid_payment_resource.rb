module V1
  class BidPaymentResource < BaseResource
    attribute :amount

    has_one :bid

    has_one :payment

    class << self
      def creatable_fields(context)
        super
      end
      alias_method :updatable_fields, :creatable_fields
    end

  end
end
