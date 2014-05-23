class CreateSubRegions < ActiveRecord::Migration
  def change
    create_table :sub_regions do |t|
    	t.references :region, index: true
    	t.string :code
      t.string :name
      t.timestamps
    end
  end
end
