class RemoveBidTypeFromBidGroups < ActiveRecord::Migration
  def change
    remove_column :bid_groups, :bid_type_id
  end
end
