class CreateDonationCategories < ActiveRecord::Migration
  def change
    create_table :donation_categories do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :donation_categories, :name, unique: true
  end
end
