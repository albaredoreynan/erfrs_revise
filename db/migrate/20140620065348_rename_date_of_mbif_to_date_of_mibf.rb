class RenameDateOfMbifToDateOfMibf < ActiveRecord::Migration
  def change
    rename_column(:subprojects, :date_of_mbif, :date_of_mibf)
  end
end
