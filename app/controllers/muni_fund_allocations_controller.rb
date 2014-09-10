class MuniFundAllocationsController < ApplicationController
	respond_to :html, :json
  before_filter :subheader
	#has_scope :region_id
  has_scope :municipality_id
	
	def index
		# @muni_fund_allocation = apply_scopes(MuniFundAllocation).all
		@muni_fund_allocations = apply_scopes(MuniFundAllocation)
    @muni_fund_allocations = @muni_fund_allocations.paginate(page: params[:page]) unless request.url =~ /json$/
    @muni_fund_allocations
	end	

	def new
		@muni_fund_allocation = MuniFundAllocation.new
		# @municipality = Municipality.select('name').find(params[:municipality_id])
	end

	def edit
		@muni_fund_allocation = MuniFundAllocation.find(params[:id])
	end

	def create
		@muni_fund_allocation = MuniFundAllocation.new(muni_fund_allocation_params)
		@muni_fund_allocation.amount = muni_fund_allocation_params[:amount].gsub(/,/, '').to_f
  	if @muni_fund_allocation.save
      flash[:success] = 'Fund Allocation for this municipality has been created.'
      redirect_to muni_fund_allocations_path
    else
      flash[:error] = 'An error occured while creating entries.'
      render 'new'
    end
	end

	def update
		@muni_fund_allocation = MuniFundAllocation.find params[:id]
		params[:muni_fund_allocation][:amount] = muni_fund_allocation_params[:amount].gsub(/,/, '').to_f
    if @muni_fund_allocation.update_attributes muni_fund_allocation_params
      flash[:success] = 'Fund Allocation for this municipality has been updated.'
      redirect_to muni_fund_allocations_path
    else
      flash[:error] = 'An error occured while updating the entries'
      render 'edit'
    end
	end


	def delete
		@muni_fund_allocation = MuniFundAllocation.find(params[:id])
    @muni_fund_allocation.destroy!
    flash[:success] = 'Regional Officer has been remove.'
    redirect_to muni_fund_allocations_path
	end

  def subheader
    @hide_nav = true
  end
  
	private
		def muni_fund_allocation_params
		  params.require(:muni_fund_allocation).permit(:year, :amount, :municipality_id)
		end
end
