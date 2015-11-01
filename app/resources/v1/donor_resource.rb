module V1
  class DonorResource < BaseResource
    has_one :user
    has_one :auction
    has_many :donation_donors

    class << self
      def creatable_fields(context)
        super - [:donation_donors]
      end

      alias_method :updatable_fields, :creatable_fields
    end

  end
end
