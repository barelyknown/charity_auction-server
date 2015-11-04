class BidderTicket < ActiveRecord::Base
  belongs_to :bidder

  belongs_to :ticket

  validates :bidder, presence: true

  validates :ticket, presence: true
end
