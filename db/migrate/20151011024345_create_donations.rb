class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :title
      t.text :description
      t.integer :quantity
      t.belongs_to :auction, index: true, foreign_key: true, null: false
      t.belongs_to :bid_type, index: true, foreign_key: true
      t.belongs_to :donor, index: true, null: false
      t.datetime :redemption_window_starts_at
      t.datetime :redemption_window_ends_at
      t.integer :estimated_value_dollars
      t.integer :minimum_bid_dollars
      t.text :display_description
      t.boolean :admin_follow_up_needed
      t.integer :fulfillment_type

      t.timestamps null: false
    end

    add_foreign_key :donations, :users, column: :donor_id
  end
end
