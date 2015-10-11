class Bid < ActiveRecord::Base
  belongs_to :donation

  belongs_to :bidder, class_name: "User"

  ["donation", "bidder", "amount_dollars", "quantity", "placed_at"].each do |required_attribute|
    validates required_attribute, presence: true
  end

  validates :amount_dollars, numericality: { greater_than: 0 }

  validate :_quantity_between_1_and_donation_quantity

  def _quantity_between_1_and_donation_quantity
    return unless quantity && donation.try(:quantity)

    unless 1 <= quantity && quantity <= donation.quantity
      errors.add :quantity, "must be greater than or equal to 1 and less than or equal to #{donation.quantity}"
    end
  end
end
