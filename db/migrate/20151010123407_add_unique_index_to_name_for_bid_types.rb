class AddUniqueIndexToNameForBidTypes < ActiveRecord::Migration
  def change
    add_index :bid_types, :name, unique: true
  end
end
