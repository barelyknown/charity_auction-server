class CreateBidGroups < ActiveRecord::Migration
  def change
    create_table :bid_groups do |t|
      t.belongs_to :bid_type, index: true, foreign_key: true, null: false
      t.string :name
      t.text :description
      t.integer :sequence

      t.timestamps null: false
    end
  end
end
