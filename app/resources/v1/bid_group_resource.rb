module V1
  class BidGroupResource < BaseResource
    has_one :auction
    has_one :bid_type
    attribute :name
    attribute :description
    attribute :sequence_position
  end
end
