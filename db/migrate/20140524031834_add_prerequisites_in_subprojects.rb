class AddPrerequisitesInSubprojects < ActiveRecord::Migration
  def change
     add_column :subprojects, :date_encoded, :date
     add_column :subprojects, :date_of_mbif, :date
     add_column :subprojects, :cycle, :integer
     add_column :subprojects, :group_id, :integer
  end
end
