class AddOrganizationToAuctions < ActiveRecord::Migration
  def change
    add_reference :auctions, :organization, index: true, foreign_key: true, null: false
  end
end
