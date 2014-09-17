class Addfieldforsubprojects < ActiveRecord::Migration
  def change
  	add_column :subprojects, :tranch_one_percentage, :integer
  	add_column :subprojects, :tranch_two_percentage, :integer
  	add_column :subprojects, :tranch_three_percentage, :integer
  end
end
