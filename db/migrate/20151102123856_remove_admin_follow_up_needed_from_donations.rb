class RemoveAdminFollowUpNeededFromDonations < ActiveRecord::Migration
  def change
    remove_column :donations, :admin_follow_up_needed
  end
end
