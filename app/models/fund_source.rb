class FundSource < ActiveRecord::Base
	has_many :fund_allocations
end
