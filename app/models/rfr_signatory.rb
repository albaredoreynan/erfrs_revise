class RfrSignatory < ActiveRecord::Base
	belongs_to :regional_officer
	belongs_to :request_for_fund_realease
end

