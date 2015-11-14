class Payment < ActiveRecord::Base
  belongs_to :auction

  belongs_to :bidder

  has_many :bid_payments

  validates :amount, numericality: { greater_than: 0 }

  validates :auction, presence: true

  enum payment_method: [:cash, :check, :credit_card]

  def applied_amount
    bid_payments.sum(:amount)
  end

  def unapplied_amount
    amount - applied_amount
  end
end
