class AddAuctionToBidGroup < ActiveRecord::Migration
  def change
    add_reference :bid_groups, :auction, index: true, foreign_key: true, null: false
  end
end
