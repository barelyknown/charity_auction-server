class User < ActiveRecord::Base
  has_many :auction_admins

  has_many :donations, foreign_key: :donor_id

  has_many :bids, foreign_key: :bidder_id

  validates :name, presence: true

  validates :mobile_phone_number, presence: true, uniqueness: true

  validates :email_address, presence: true, uniqueness: true

  validates :physical_address, presence: true
end
