class AddExcelRemarksToRequestForFundRelease < ActiveRecord::Migration
  def change
    add_column :request_for_fund_releases, :excel_remark, :string
  end
end
