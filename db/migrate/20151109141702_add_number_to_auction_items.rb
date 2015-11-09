class AddNumberToAuctionItems < ActiveRecord::Migration
  def change
    add_column :auction_items, :number, :string
  end
end
