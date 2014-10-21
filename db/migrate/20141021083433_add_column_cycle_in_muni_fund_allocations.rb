class AddColumnCycleInMuniFundAllocations < ActiveRecord::Migration
  def change
  	add_column :muni_fund_allocations, :cycle, :integer
  end
end
