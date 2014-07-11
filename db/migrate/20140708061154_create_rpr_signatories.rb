class CreateRprSignatories < ActiveRecord::Migration
  def change
    create_table :rfr_signatories do |t|
    	t.references :request_for_fund_release, index: true
      t.references :regional_officer, index: true
      t.timestamps
    end
  end
end
