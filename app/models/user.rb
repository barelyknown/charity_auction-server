class User < ActiveRecord::Base
  has_many :auction_admins

  validates :name, presence: true

  validates :mobile_phone_number, presence: true, uniqueness: true

  validates :email_address, presence: true, uniqueness: true

  validates :physical_address, presence: true
end
