class AddSupplementaryColumnsToRfrs < ActiveRecord::Migration
  def change
    add_column :request_for_fund_releases, :account_name, :string
  end
end
