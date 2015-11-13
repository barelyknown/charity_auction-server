class CreateBids < ActiveRecord::Migration
  def change
    drop_table(:bids) if table_exists?(:bids)
    
    create_table :bids do |t|
      t.belongs_to :auction_item, index: true, foreign_key: true, null: false
      t.belongs_to :bidder, index: true, foreign_key: true, null: false
      t.boolean :winner, default: false
      t.decimal :amount, null: false

      t.timestamps null: false
    end
  end
end
