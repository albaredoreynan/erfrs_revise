class CreateMuniFundAllocations < ActiveRecord::Migration
  def change
    create_table :muni_fund_allocations do |t|
    	t.integer :year
    	t.decimal :amount, precision: 15, scale: 2, null: false, default: 0
    	t.integer :municipality_id
      t.timestamps
    end
  end
end
