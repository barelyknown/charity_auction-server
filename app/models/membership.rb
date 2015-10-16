class Membership < ActiveRecord::Base
  belongs_to :user

  belongs_to :organization

  validates :user, presence: true

  validates :organization, presence: true

  validate :_user_and_organization_have_not_changed

  def _user_and_organization_have_not_changed
    return unless persisted?

    ["user", "organization"].each do |relationship|
      if changes.key?(relationship + "_id")
        errors.add relationship, "cannot be changed"
      end
    end
  end
end
