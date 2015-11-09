class AddGroupByDonationCategoryToBidGroups < ActiveRecord::Migration
  def change
    add_column :bid_groups, :group_by_donation_category, :boolean, default: false
  end
end
