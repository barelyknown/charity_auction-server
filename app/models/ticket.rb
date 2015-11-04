class Ticket < ActiveRecord::Base
  belongs_to :user

  belongs_to :auction

  has_many :bidder_tickets

  has_many :bidders, through: :bidder_tickets

  validates :user, presence: true

  validates :auction, presence: true

  validates :number, presence: true, uniqueness: { scope: :auction_id }

  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :_set_number_unless_present

  after_commit :_create_bidder, on: [:create]

  def _set_number_unless_present
    return if number.present? || auction.nil?

    self.number = _next_number_in_auction
  end

  def _next_number_in_auction
    (auction.tickets.pluck(:number).map(&:to_i).sort.last.to_i + 1).to_s
  end

  def _create_bidder
    Bidder.create!(auction: auction, tickets: [self]) and reload
  end
end
