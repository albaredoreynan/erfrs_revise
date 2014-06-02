class AddFieldsOnRfrsTable < ActiveRecord::Migration
  def change
  	add_column :request_for_fund_releases, :requested_by_first, :integer
  	add_column :request_for_fund_releases, :designation_first, :string
  	add_column :request_for_fund_releases, :date_first, :datetime

  	add_column :request_for_fund_releases, :requested_by_second, :integer
  	add_column :request_for_fund_releases, :designation_second, :string
  	add_column :request_for_fund_releases, :date_second, :datetime
  	
  	add_column :request_for_fund_releases, :date_received, :datetime

  	add_column :request_for_fund_releases, :reviewed_by_first, :integer
  	add_column :request_for_fund_releases, :rev_designation_first, :string
  	add_column :request_for_fund_releases, :rev_date_first, :datetime

  	add_column :request_for_fund_releases, :reviewed_by_second, :integer
  	add_column :request_for_fund_releases, :rev_designation_second, :string
  	add_column :request_for_fund_releases, :rev_date_second, :datetime

  	add_column :request_for_fund_releases, :srpmo_date_received, :datetime

  	add_column :request_for_fund_releases, :srpmo_reviewed_by, :integer
  	add_column :request_for_fund_releases, :srpmo_designation, :string
  	add_column :request_for_fund_releases, :srpmo_date, :datetime

  	add_column :request_for_fund_releases, :srpmo_recommend_by, :integer
  	add_column :request_for_fund_releases, :srpmo_rec_designation, :string
  	add_column :request_for_fund_releases, :srpmo_rec_date, :datetime

  	add_column :request_for_fund_releases, :rpmo_date_received, :datetime

  	add_column :request_for_fund_releases, :rpmo_approved_by, :integer
  	add_column :request_for_fund_releases, :rpmo_designation, :string
  	add_column :request_for_fund_releases, :rpmo_date, :datetime

  	add_column :request_for_fund_releases, :approved_as_requested, :bool
  end
end
