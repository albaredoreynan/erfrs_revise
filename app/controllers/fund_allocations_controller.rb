class FundAllocationsController < InheritedResources::Base
	actions :all, except: :show
  
  respond_to :html, :json
  before_filter :subheader

  def subheader
    @hide_nav = true
  end
  
  # def new
  #   @fund_allocation = FundAllocation.new permitted_params
  # end

  def create
    @fund_allocation = FundAllocation.new fa_params
    @fund_allocation.amount = fa_params[:amount].gsub(/,/, '').to_f
    create!
  end

  def update
    @fund_allocation = FundAllocation.find params[:id]
    params[:fund_allocation][:amount] = fa_params[:amount].gsub(/,/, '').to_f
    update!
  end

  protected

    def fa_params
      attrs = [:fund_source_id, :start_date, :end_date, :amount, :year] 
      params.require(:fund_allocation).permit(attrs)
    end

    def permitted_params
      params.permit(fund_allocation: %i[fund_source_id start_date end_date amount year])
    end

    def collection
      @fund_allocations = apply_scopes(FundAllocation)
      @fund_allocations = @fund_allocations.paginate(page: params[:page]) unless request.url =~ /json$/
      @fund_allocations
    end
end