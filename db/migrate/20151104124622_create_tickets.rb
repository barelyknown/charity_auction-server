class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false
      t.decimal :price, null: false
      t.belongs_to :auction, index: true, foreign_key: true, null: false
      t.string :number, null: false

      t.timestamps null: false
    end
  end
end
