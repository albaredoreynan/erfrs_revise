class AddNewFieldsAcrossTables < ActiveRecord::Migration
  def change
  	
  	# regions
  	add_column :regions, :for_regional_accounting, :string
  	add_column :regions, :for_management_division_head, :string
  	add_column :regions, :for_regional_director, :string
  	add_column :regions, :for_asst_regional_director_opt, :string
  	add_column :regions, :for_asst_regional_director_adm, :string
  	add_column :regions, :for_budget_officer, :string

  	#fund allocations
		add_column :fund_allocations, :year, :integer
  end
end
