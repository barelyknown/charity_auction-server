class DonationDonor < ActiveRecord::Base
  belongs_to :donation

  belongs_to :donor

  validates :donation, presence: true

  validates :donor, presence: true
end
