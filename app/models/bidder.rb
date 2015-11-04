class Bidder < ActiveRecord::Base
  belongs_to :auction

  has_many :bidder_tickets

  has_many :tickets, through: :bidder_tickets

  validates :auction, presence: true

  validate :_tickets_are_not_empty

  def _tickets_are_not_empty
    if tickets.empty?
      errors.add :tickets, "must not be empty"
    end
  end
end
