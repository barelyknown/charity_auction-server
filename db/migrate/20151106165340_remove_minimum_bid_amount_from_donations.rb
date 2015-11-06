class RemoveMinimumBidAmountFromDonations < ActiveRecord::Migration
  def change
    remove_column :donations, :minimum_bid_amount
  end
end
