class FixNotNullConstraintsForUsers < ActiveRecord::Migration
  def change
    change_column :users, :mobile_phone_number, :string, null: true
    change_column :users, :email_address, :string, null: true
    change_column :users, :physical_address, :string, null: true
  end
end
