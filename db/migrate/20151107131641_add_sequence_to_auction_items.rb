class AddSequenceToAuctionItems < ActiveRecord::Migration
  def change
    add_column :auction_items, :sequence, :integer
  end
end
