class BidType < ActiveRecord::Base
  validates :name, uniqueness: true, presence: true

  has_many :donations

  has_many :bid_groups
end
