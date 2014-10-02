class RfrSignatory < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
	belongs_to :regional_officer
	belongs_to :request_for_fund_realease
end

