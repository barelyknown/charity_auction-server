class RemoveNullConstraintOnAuctionsBidGroup < ActiveRecord::Migration
  def change
    change_column :auction_items, :bid_group_id, :integer, null: true
  end
end
