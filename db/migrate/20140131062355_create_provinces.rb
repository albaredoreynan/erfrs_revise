class CreateProvinces < ActiveRecord::Migration
  def change
    create_table :provinces do |t|
      t.references :region, index: true
      t.string :name

      t.timestamps
    end
  end
end
