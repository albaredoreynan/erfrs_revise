class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
    	t.string :code
    	t.string :status
      t.timestamps
    end
  end
end
