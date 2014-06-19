class RenameTypeInRegionalOfficer < ActiveRecord::Migration
  def change
    rename_column :regional_officers, :type, :ro_type
  end
end
