class Addfieldforaddressinregion < ActiveRecord::Migration
  def change
  	add_column :regions, :address_region, :text
  end
end
