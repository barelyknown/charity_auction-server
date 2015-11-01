module V1
  class DonationDonorResource < BaseResource
    has_one :donation
    has_one :donor
  end
end
