class ChangeDollarsColumnsForDonations < ActiveRecord::Migration
  def change
    rename_column :donations, :minimum_bid_dollars, :minimum_bid_amount
    rename_column :donations, :estimated_value_dollars, :estimated_value_amount
  end
end
