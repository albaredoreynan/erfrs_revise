class CreateFundAllocations < ActiveRecord::Migration
  def change
    create_table :fund_allocations do |t|
    	t.references :region, index: true
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :amount, precision: 15, scale: 2, null: false, default: 0
      t.timestamps
    end
  end
end
