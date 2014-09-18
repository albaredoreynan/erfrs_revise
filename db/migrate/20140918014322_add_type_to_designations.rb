class AddTypeToDesignations < ActiveRecord::Migration
  def change
    add_column :designations, :designation_type, :string
  end
end
