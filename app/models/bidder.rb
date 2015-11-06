class Bidder < ActiveRecord::Base
  belongs_to :auction

  has_many :bidder_tickets, dependent: :destroy

  has_many :tickets, through: :bidder_tickets

  validates :auction, presence: true

  validate :_tickets_are_not_empty

  validates :number, uniqueness: { scope: :auction_id }, presence: true

  before_validation :_set_number_unless_present

  def _tickets_are_not_empty
    if tickets.empty?
      errors.add :tickets, "must not be empty"
    end
  end

  def _set_number_unless_present
    return if number.present? || auction.nil?

    self.number = _next_number_in_auction
  end

  def _next_number_in_auction
    (auction.bidders.pluck(:number).map(&:to_i).sort.last.to_i + 1).to_s
  end
end
