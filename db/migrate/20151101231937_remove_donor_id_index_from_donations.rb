class RemoveDonorIdIndexFromDonations < ActiveRecord::Migration
  def change
    remove_column :donations, :donor_id
  end
end
