module V1
  class BidderResource < BaseResource
    has_one :auction
    has_many :tickets, acts_as_set: true
  end
end
