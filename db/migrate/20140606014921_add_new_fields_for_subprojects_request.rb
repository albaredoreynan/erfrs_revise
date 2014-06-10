class AddNewFieldsForSubprojectsRequest < ActiveRecord::Migration
  def change
  	add_column :request_for_fund_releases, :tranch_for, :integer
  	add_column :subprojects, :first_tranch_amount_release, :decimal, precision: 15, scale: 2, null: false, default: 0
  	add_column :subprojects, :second_tranch_amount_release, :decimal, precision: 15, scale: 2, null: false, default: 0
  	add_column :subprojects, :third_tranch_amount_release, :decimal, precision: 15, scale: 2, null: false, default: 0
  end
end
