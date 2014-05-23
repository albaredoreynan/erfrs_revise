class CreateFundSources < ActiveRecord::Migration
  def change
    create_table :fund_sources do |t|
    	t.string :code
      t.string :name
      t.timestamps
    end
  end
end
