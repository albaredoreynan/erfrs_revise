class ChangeDesignationToDesignationId < ActiveRecord::Migration
  def change
    remove_column(:team_members, :designation)
    add_column(:team_members, :designation_id, :integer)
  end
end
