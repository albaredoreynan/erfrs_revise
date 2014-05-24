class AddContigencyValuesToSubprojects < ActiveRecord::Migration
  def change
    add_column :subprojects, :grant_amount_contigency_cost, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :lcc_contigency_cost, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :community_contigency_cost, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :mlgu_contigency_cost, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :plgu_contigency_cost, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :total_lcc_cash_contigency_cost, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :total_lcc_in_kind_contigency_cost, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :first_tranch_revised_amount, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :second_tranch_revised_amount, :decimal, precision:15, scale: 2, default:0.0, null:false
    add_column :subprojects, :third_tranch_revised_amount, :decimal, precision:15, scale: 2, default:0.0, null:false
  end
end
