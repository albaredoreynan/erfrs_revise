class CreateTableCgdpsSaaEntries < ActiveRecord::Migration
  def change
    create_table :table_cgdps_saa_entries do |t|
    	t.integer :cgdp_id
    	t.integer :subproject_id
    	t.string :saa_number
    	t.datetime :saa_date
    	t.decimal :saa_amount, precision: 15, scale: 2, null: false, default: 0
      t.timestamps
    end
    
  end
end
