class CreateAuctionAdmins < ActiveRecord::Migration
  def change
    create_table :auction_admins do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.belongs_to :auction, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
