module V1
  class TicketResource < BaseResource
    attribute :price
    attribute :number
    has_one :auction
    has_one :user
  end
end
