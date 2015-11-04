module V1
  class UserResource < BaseResource
    attribute :name
    attribute :mobile_phone_number
    attribute :email_address
    attribute :physical_address
    attribute :password

    has_many :memberships

    has_many :donors

    has_many :tickets

    class << self
      def creatable_fields(context)
        super - [:memberships, :donors, :tickets]
      end

      alias_method :updatable_fields, :creatable_fields
    end

    def fetchable_fields
      super - [:password]
    end
  end
end
