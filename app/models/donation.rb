class Donation < ActiveRecord::Base
  belongs_to :auction

  belongs_to :bid_type

  belongs_to :donation_category

  belongs_to :donor, class_name: "User"

  has_many :bids

  enum fulfillment_type: [:item, :certificate]

  validates :donor, presence: true

  validates :auction, presence: true

  validates :quantity, numericality: { greater_than: 0 }, allow_nil: true

  validates :minimum_bid_amount, numericality: { greater_than: 0 }, allow_nil: true

  validate :_redemption_window_ends_at_greater_than_starts_at

  validates :estimated_value_amount, numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def _redemption_window_ends_at_greater_than_starts_at
    return unless redemption_window_ends_at && redemption_window_starts_at

    if redemption_window_ends_at <= redemption_window_starts_at
      errors.add :redemption_window_ends_at, "must be greater than redemption_window_starts_at"
    end
  end
end
