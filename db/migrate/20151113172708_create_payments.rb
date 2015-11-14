class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :bidder, index: true, foreign_key: true
      t.decimal :amount, null: false
      t.integer :payment_method

      t.timestamps null: false
    end
  end
end
