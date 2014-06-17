class RenameContingencyToContingencyCost < ActiveRecord::Migration
  def change
    rename_column(:subprojects, :plgu_contingency_cost, :plgu_others_contingency_cost)
    rename_column(:subprojects, :lcc_contingency_cost, :lcc_blgu_contingency_cost)
  end
end
