class CreateMunicipalities < ActiveRecord::Migration
  def change
    create_table :municipalities do |t|
      t.references :province, index: true
      t.string :name

      t.timestamps
    end
  end
end
