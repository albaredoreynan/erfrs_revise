class DestroySuperUserTable < ActiveRecord::Migration
  def change
    drop_table :super_users
  end
end
