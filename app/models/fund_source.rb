class FundSource < ActiveRecord::Base
	has_many :fund_allocations
  has_many :groups
end
