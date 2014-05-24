class AddNewFieldToTableFundAllocations < ActiveRecord::Migration
  def change
  	remove_column :fund_allocations, :region_id
  	add_column :fund_allocations, :fund_source_id, :integer
  end
end
