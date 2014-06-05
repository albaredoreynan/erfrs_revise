class AddFundSourceIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :fund_source_id, :integer
  end
end
