module V1
  class AuctionResource < BaseResource
    attribute :starts_at
    attribute :ends_at
    attribute :time_zone_id
    attribute :physical_address
    attribute :name
    attribute :donation_window_ends_at

    has_one :organization

    has_many :donations

    class << self
      def creatable_fields(context)
        super - [:donations]
      end
      alias_method :updatable_fields, :creatable_fields
    end
  end
end
