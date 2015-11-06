class AuctionItem < ActiveRecord::Base
  [:donation, :auction, :bid_type].each do |relationship|
    belongs_to relationship
    validates relationship, presence: true
  end

  belongs_to :bid_group

  with_options unless: -> { bid_type.try(:name) == "fixed-price" } do
    validates :minimum_bid_amount, numericality: { greater_than: 0 }, allow_nil: true
  end

  with_options if: -> { bid_type.try(:name) == "fixed-price" } do
    validates :minimum_bid_amount, numericality: { greater_than: 0 }
  end
end
