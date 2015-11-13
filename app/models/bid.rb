class Bid < ActiveRecord::Base
  belongs_to :auction_item
  belongs_to :bidder
end
