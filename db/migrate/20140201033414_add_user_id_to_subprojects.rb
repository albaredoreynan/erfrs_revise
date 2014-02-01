class AddUserIdToSubprojects < ActiveRecord::Migration
  def change
    add_column :subprojects, :user_id, :integer
    add_index  :subprojects, :user_id
  end
end
