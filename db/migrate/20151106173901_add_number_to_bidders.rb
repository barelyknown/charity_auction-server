class AddNumberToBidders < ActiveRecord::Migration
  def change
    add_column :bidders, :number, :string
  end
end
