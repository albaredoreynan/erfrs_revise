class AddFieldsToRfrSignatory < ActiveRecord::Migration
  def change
  	add_column :rfr_signatories, :group, :string
  	add_column :rfr_signatories, :sign_type, :string
  end
end
