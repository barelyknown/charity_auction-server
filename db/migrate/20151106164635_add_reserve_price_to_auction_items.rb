class AddReservePriceToAuctionItems < ActiveRecord::Migration
  def change
    add_column :auction_items, :minimum_bid_amount, :decimal
  end
end
