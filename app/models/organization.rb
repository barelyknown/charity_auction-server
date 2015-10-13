class Organization < ActiveRecord::Base

  has_many :auctions

  has_many :memberships

  validates :name, presence: true

end
