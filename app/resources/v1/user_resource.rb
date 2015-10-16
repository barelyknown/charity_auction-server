module V1
  class UserResource < BaseResource
    attribute :name
    attribute :mobile_phone_number
    attribute :email_address
    attribute :physical_address
    attribute :password

    def fetchable_fields
      super - [:password]
    end
  end
end
