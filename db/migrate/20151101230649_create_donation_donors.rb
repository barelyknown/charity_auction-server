class CreateDonationDonors < ActiveRecord::Migration
  def change
    create_table :donation_donors do |t|
      t.belongs_to :donation, index: true, foreign_key: true
      t.belongs_to :donor, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
