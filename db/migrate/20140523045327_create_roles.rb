class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
    	t.string 	:name
    	t.integer :code
    	t.integer :locale
      t.timestamps
    end
  end
end
