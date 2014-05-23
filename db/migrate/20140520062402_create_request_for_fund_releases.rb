class CreateRequestForFundReleases < ActiveRecord::Migration
  def change
    create_table :request_for_fund_releases do |t|
      t.references :subproject
      t.string :status
      t.string :rfr_type
      t.datetime :request_date
      t.string :bank_account_number
      t.string :address
      t.string :branch
      t.string :city
      t.string :province
      t.string :phone
      t.decimal :amount_approve
      t.string :remarks
      t.string :obr_number
      t.datetime :obr_date
      t.string :dv_number
      t.datetime :dv_date
      t.string :check_number
      t.string :check_date
      t.timestamps
    end
  end
end
