class AddGroupIdToMunicipalities < ActiveRecord::Migration
  def change
    add_column :municipalities, :group_id, :integer
    add_index  :municipalities, :group_id
  end
end
