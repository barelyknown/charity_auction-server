module V1
  class PaymentResource < BaseResource
    has_one :bidder

    has_one :auction

    attribute :amount

    attribute :payment_method

    attribute :applied_amount

    attribute :unapplied_amount

    class << self
      def creatable_fields(context)
        super - [:applied_amount, :unapplied_amount]
      end
      alias_method :updatable_fields, :creatable_fields
    end
  end
end
