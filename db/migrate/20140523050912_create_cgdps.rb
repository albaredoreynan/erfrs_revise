class CreateCgdps < ActiveRecord::Migration
  def change
    create_table :cgdps do |t|
    	t.references :municipality, index: true
    	t.integer :year
    	t.string :status
    	t.string :saa_number
    	t.datetime :saa_date
      t.timestamps
    end
  end
end