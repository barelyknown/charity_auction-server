class Donor < ActiveRecord::Base
  belongs_to :user

  belongs_to :auction

  validates :user, presence: true

  validates :auction, presence: true

  has_many :donation_donors, dependent: :restrict_with_error

  has_many :donations, through: :donation_donors
end
