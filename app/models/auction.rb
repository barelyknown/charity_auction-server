class Auction < ActiveRecord::Base

  belongs_to :organization

  has_many :donations

  has_many :donors

  has_many :tickets

  has_many :bidders

  has_many :bid_groups

  has_many :auction_items

  has_many :payments

  validate :_starts_at_after_donation_window_ends_at

  validate :_ends_at_after_starts_at

  validates :time_zone_id, inclusion: { in: ActiveSupport::TimeZone.all.map { |tz| tz.tzinfo.identifier } }, allow_blank: true

  validates :organization, presence: true

  def _ends_at_after_starts_at
    return unless starts_at && ends_at

    if ends_at <= starts_at
      errors.add :ends_at, "must be greater than starts_at"
    end
  end

  def _starts_at_after_donation_window_ends_at
    return unless starts_at && donation_window_ends_at

    if starts_at <= donation_window_ends_at
      errors.add :starts_at, "must be greater than donation_window_ends_at"
    end
  end

end
