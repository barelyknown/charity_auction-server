class CreateBidPayments < ActiveRecord::Migration
  def change
    create_table :bid_payments do |t|
      t.belongs_to :bid, index: true, foreign_key: true, null: false
      t.belongs_to :payment, index: true, foreign_key: true, null: false
      t.decimal :amount, null: false

      t.timestamps null: false
    end
  end
end
