class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :mobile_phone_number, null: false
      t.string :email_address, null: false
      t.string :physical_address, null: false

      t.timestamps null: false
    end
    add_index :users, :email_address, unique: true
    add_index :users, :mobile_phone_number, unique: true
  end
end
