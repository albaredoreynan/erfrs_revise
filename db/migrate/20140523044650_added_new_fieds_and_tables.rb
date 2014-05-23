class AddedNewFiedsAndTables < ActiveRecord::Migration
  def change
  	add_column :users, :role_id, :integer
  	add_column :users, :status, :string
  end
end
