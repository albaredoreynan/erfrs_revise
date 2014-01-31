class CreateBarangays < ActiveRecord::Migration
  def change
    create_table :barangays do |t|
      t.references :municipality, index: true
      t.string :name

      t.timestamps
    end
  end
end
