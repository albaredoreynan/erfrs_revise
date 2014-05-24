class RenameGrantAmountContigencyCostToGrantAmountContingencyFromSubproject < ActiveRecord::Migration
  def change
    rename_column(:subprojects, :grant_amount_contigency_cost, :grant_amount_contingency_cost)
    rename_column(:subprojects, :lcc_contigency_cost, :lcc_contingency_cost)
    rename_column(:subprojects, :community_contigency_cost, :community_contingency_cost)
    rename_column(:subprojects, :mlgu_contigency_cost, :mlgu_contingency_cost)
    rename_column(:subprojects, :plgu_contigency_cost, :plgu_contingency_cost)
    rename_column(:subprojects, :total_lcc_in_kind_contigency_cost, :total_lcc_in_kind_contingency_cost)
  end
end
