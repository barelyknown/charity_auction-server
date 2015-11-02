class AddNotesToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :notes, :text
  end
end
