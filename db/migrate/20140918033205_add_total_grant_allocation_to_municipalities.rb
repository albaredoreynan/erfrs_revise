class AddTotalGrantAllocationToMunicipalities < ActiveRecord::Migration
  def change
    add_column :municipalities, :total_grant_allocation, :decimal, precision: 15, scale: 2
  end
end
