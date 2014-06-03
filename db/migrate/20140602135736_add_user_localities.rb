class AddUserLocalities < ActiveRecord::Migration
  def change
    add_column :users, :region_id, :integer
    add_column :users, :municipality_id, :integer
    add_column :users, :province_id, :integer
    add_column :users, :barangay_id, :integer
  end
end
