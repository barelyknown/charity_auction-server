class AuctionItem < ActiveRecord::Base
  include RankedModel

  ranks :sequence, with_same: :auction_id

  default_scope { rank(:sequence) }

  [:donation, :auction, :bid_type].each do |relationship|
    belongs_to relationship
    validates relationship, presence: true
  end

  belongs_to :bid_group

  validates :number, uniqueness: { scope: :auction_id }, presence: true

  before_validation :_set_number_unless_present

  with_options unless: -> { bid_type.try(:name) == "fixed-price" } do
    validates :minimum_bid_amount, numericality: { greater_than: 0 }, allow_nil: true
  end

  with_options if: -> { bid_type.try(:name) == "fixed-price" } do
    validates :minimum_bid_amount, numericality: { greater_than: 0 }
  end

  def _set_number_unless_present
    return if number.present? || auction.nil?

    self.number = _next_number_in_auction
  end

  def _next_number_in_auction
    (auction.auction_items.pluck(:number).map(&:to_i).sort.last.to_i + 1).to_s
  end
end
