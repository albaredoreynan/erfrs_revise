class FundSource < ActiveRecord::Base
	has_many :fund_allocations
  has_many :groups
  has_many :subprojects
end
