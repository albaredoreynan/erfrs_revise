class AddExchangeRateToSubproject < ActiveRecord::Migration
  def change
    add_column :request_for_fund_releases, :exchange_rate, :integer
  end
end
