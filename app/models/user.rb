class User < ActiveRecord::Base
  include ActiveModel::SecurePassword::InstanceMethodsOnActivation

  has_many :donations, foreign_key: :donor_id

  has_many :bids, foreign_key: :bidder_id

  has_many :memberships

  has_many :donors

  validates :name, presence: true

  validates :mobile_phone_number, uniqueness: true, allow_blank: true

  validates :email_address, uniqueness: true, allow_blank: true
end
