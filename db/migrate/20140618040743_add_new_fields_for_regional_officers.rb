class AddNewFieldsForRegionalOfficers < ActiveRecord::Migration
  def change
  	add_column :regional_officers, :box, :string
  end
end
