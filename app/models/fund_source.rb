class FundSource < ActiveRecord::Base
  include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller.current_user }
  
	has_many :fund_allocations
  has_many :groups
  has_many :subprojects
end
