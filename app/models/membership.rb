class Membership < ActiveRecord::Base
  belongs_to :user

  belongs_to :organization

  validates :user, presence: true

  validates :organization, presence: true
end
