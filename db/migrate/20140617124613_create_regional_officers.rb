class CreateRegionalOfficers < ActiveRecord::Migration
  def change
    create_table :regional_officers do |t|
      t.string :name
      t.string :designation
      t.string :type
      t.references :region, index: true

      t.timestamps
    end
  end
end
