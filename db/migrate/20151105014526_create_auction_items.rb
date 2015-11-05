class CreateAuctionItems < ActiveRecord::Migration
  def change
    create_table :auction_items do |t|
      t.belongs_to :auction, index: true, foreign_key: true, null: false
      t.belongs_to :donation, index: true, foreign_key: true, null: false
      t.belongs_to :bid_type, index: true, foreign_key: true, null: false
      t.belongs_to :bid_group, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
