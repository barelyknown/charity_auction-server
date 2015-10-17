module V1
  class OrganizationResource < BaseResource
    attribute :name

    has_many :memberships

    has_many :auctions

    class << self
      def creatable_fields(context)
        super - [:memberships, :auctions]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
