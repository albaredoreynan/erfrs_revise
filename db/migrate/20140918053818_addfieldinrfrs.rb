class Addfieldinrfrs < ActiveRecord::Migration
  def change
  	add_column :request_for_fund_releases, :amount_contingency, :decimal, precision:15, scale: 2, default:0.0, null:false
  end
end
