class RenameContigecyToContingency < ActiveRecord::Migration
  def change
    rename_column(:subprojects, :total_lcc_cash_contigency_cost, :total_lcc_cash_contingency_cost)
  end
end
