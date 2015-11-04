class CreateBidders < ActiveRecord::Migration
  def change
    create_table :bidders do |t|
      t.belongs_to :auction, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
