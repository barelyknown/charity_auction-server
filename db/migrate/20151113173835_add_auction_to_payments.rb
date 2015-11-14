class AddAuctionToPayments < ActiveRecord::Migration
  def change
    add_reference :payments, :auction, index: true, foreign_key: true, null: false
  end
end
