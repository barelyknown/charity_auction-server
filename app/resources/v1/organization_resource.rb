module V1
  class OrganizationResource < BaseResource
    attribute :name

    has_many :memberships

    has_many :auctions

    after_create :_create_membership_for_current_user

    def _create_membership_for_current_user
      model.memberships.create!(user: context[:current_user])
    end

    class << self
      def creatable_fields(context)
        super - [:memberships, :auctions]
      end

      alias_method :updatable_fields, :creatable_fields
    end
  end
end
