class AddBigGroupToDonations < ActiveRecord::Migration
  def change
    add_reference :donations, :bid_group, index: true, foreign_key: true
  end
end
