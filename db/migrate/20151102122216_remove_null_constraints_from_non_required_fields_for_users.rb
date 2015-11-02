class RemoveNullConstraintsFromNonRequiredFieldsForUsers < ActiveRecord::Migration
  def change
    change_column :users, :mobile_phone_number, :string
    change_column :users, :email_address, :string
    change_column :users, :physical_address, :string
    remove_index :users, :email_address
    remove_index :users, :mobile_phone_number
    add_index :users, :email_address, unique: true, where: "email_address IS NOT NULL"
  end
end
