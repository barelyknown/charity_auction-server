module V1
  class MembershipResource < BaseResource
    has_one :user
    has_one :organization
  end
end
