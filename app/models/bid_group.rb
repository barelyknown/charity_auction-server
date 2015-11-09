class BidGroup < ActiveRecord::Base
  include RankedModel

  belongs_to :auction

  has_many :auction_items

  validates :auction, presence: true

  ranks :sequence, with_same: :auction_id
end
