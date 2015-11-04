class CreateBidderTickets < ActiveRecord::Migration
  def change
    create_table :bidder_tickets do |t|
      t.belongs_to :bidder, index: true, foreign_key: true, null: false
      t.belongs_to :ticket, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
