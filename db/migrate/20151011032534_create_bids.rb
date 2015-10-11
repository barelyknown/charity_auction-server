class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.belongs_to :donation, index: true, foreign_key: true, null: false
      t.belongs_to :bidder, index: true, null: false
      t.integer :amount_dollars, null: false
      t.integer :quantity, null: false
      t.datetime :placed_at, null: false

      t.timestamps null: false
    end

    add_foreign_key :bids, :users, column: :bidder_id
  end
end
