class AuctionItem < ActiveRecord::Base
  [:donation, :auction, :bid_type].each do |relationship|
    belongs_to relationship
    validates relationship, presence: true
  end

  belongs_to :bid_group
end
