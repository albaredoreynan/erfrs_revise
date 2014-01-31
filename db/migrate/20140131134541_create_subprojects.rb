class CreateSubprojects < ActiveRecord::Migration
  def change
    create_table :subprojects do |t|
      t.string :status
      t.string :title
      t.references :region, index: true
      t.references :province, index: true
      t.references :municipality, index: true
      t.references :barangay, index: true
      t.string :category
      t.string :physical_target
      t.string :cost_parameter
      t.string :mode_of_implementation
      t.string :description
      t.references :fund_source
      t.decimal :grant_amount_direct_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :grant_amount_indirect_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :lcc_blgu_direct_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :lcc_blgu_indirect_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :community_direct_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :community_indirect_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :mlgu_direct_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :mlgu_indirect_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :plgu_others_direct_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :plgu_others_indirect_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :total_lcc_cash_direct_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :total_lcc_cash_indirect_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :total_lcc_in_kind_direct_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :total_lcc_in_kind_indirect_cost, precision: 15, scale: 2, null: false, default: 0
      t.decimal :first_tranch_amount, precision: 15, scale: 2, null: false, default: 0
      t.datetime :first_tranch_date_required
      t.decimal :second_tranch_amount, precision: 15, scale: 2, null: false, default: 0
      t.datetime :second_tranch_date_required
      t.decimal :third_tranch_amount, precision: 15, scale: 2, null: false, default: 0
      t.datetime :third_tranch_date_required

      t.timestamps
    end
  end
end
