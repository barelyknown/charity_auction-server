class Bid < ActiveRecord::Base
  belongs_to :auction_item

  belongs_to :bidder

  has_many :bid_payments

  def balance
    return unless winner? && amount

    amount - bid_payments.sum(:amount)
  end
end
