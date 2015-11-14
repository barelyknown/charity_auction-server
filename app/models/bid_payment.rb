class BidPayment < ActiveRecord::Base
  belongs_to :bid

  belongs_to :payment

  validates :bid, presence: true

  validates :payment, presence: true

  validates :amount, presence: true

  validate :_amount_less_than_or_equal_to_payment_unapplied_amount

  validate :_bid_is_a_winner

  def _amount_less_than_or_equal_to_payment_unapplied_amount
    return unless payment && amount

    if amount > payment.unapplied_amount
      errors.add :amount, "must be less than or equal to the payment's unapplied amount"
    end
  end

  def _bid_is_a_winner
    return unless bid

    if !bid.winner?
      errors.add :bid, "must be a winner"
    end
  end
end
