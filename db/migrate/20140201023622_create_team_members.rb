class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.references :subproject, index: true
      t.string :name
      t.string :designation
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
