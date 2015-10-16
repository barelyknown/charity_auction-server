module V1
  class OrganizationResource < BaseResource
    attribute :name

    has_many :memberships

    class << self
      def creatable_fields(context)
        super - [:memberships]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
