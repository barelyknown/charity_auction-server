class BidGroup < ActiveRecord::Base
  include RankedModel

  belongs_to :bid_type

  belongs_to :auction

  validates :bid_type, presence: true

  validates :auction, presence: true

  ranks :sequence, with_same: :auction_id

  default_scope { rank(:sequence) }
end
