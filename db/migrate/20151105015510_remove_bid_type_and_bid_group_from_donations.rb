class RemoveBidTypeAndBidGroupFromDonations < ActiveRecord::Migration
  def change
    remove_column :donations, :bid_type_id
    remove_column :donations, :bid_group_id
  end
end
