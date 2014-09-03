class Addfieldsforsortingregion < ActiveRecord::Migration
  def change
  	add_column :regions, :equi_code, :integer
  end
end
