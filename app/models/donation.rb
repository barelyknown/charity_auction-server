class Donation < ActiveRecord::Base
  belongs_to :auction

  belongs_to :donation_category

  has_many :donation_donors

  has_many :donors, through: :donation_donors

  has_one :auction_item

  enum fulfillment_type: [:item, :certificate]

  validates :auction, presence: true

  validates :quantity, numericality: { greater_than: 0 }, allow_nil: true

  validate :_redemption_window_ends_at_greater_than_starts_at

  validates :estimated_value_amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def _redemption_window_ends_at_greater_than_starts_at
    return unless redemption_window_ends_at && redemption_window_starts_at

    if redemption_window_ends_at <= redemption_window_starts_at
      errors.add :redemption_window_ends_at, "must be greater than redemption_window_starts_at"
    end
  end
end
