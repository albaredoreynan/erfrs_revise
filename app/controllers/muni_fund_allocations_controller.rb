class MuniFundAllocationsController < ApplicationController
	respond_to :html, :json
	
	def index
		@muni_fund_allocation = MuniFundAllocation.all			
	end	
end
