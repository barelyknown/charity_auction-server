class AddDonationCategoryToDonations < ActiveRecord::Migration
  def change
    add_reference :donations, :donation_category, index: true, foreign_key: true
  end
end
