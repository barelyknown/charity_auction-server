class AddUniqueIndexToTicketsForAuctionIdAndNumber < ActiveRecord::Migration
  def change
    add_index :tickets, [:auction_id, :number], unique: true
  end
end
