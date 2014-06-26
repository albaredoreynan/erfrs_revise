class FundAllocationsController < InheritedResources::Base
	actions :all, except: :show
  
  respond_to :html, :json
  before_filter :subheader

  def subheader
    @hide_nav = true
  end
  
  protected

    def permitted_params
      params.permit(fund_allocation: %i[fund_source_id start_date end_date amount year])
    end

    def collection
      @fund_allocations = apply_scopes(FundAllocation)
      @fund_allocations = @fund_allocations.paginate(page: params[:page]) unless request.url =~ /json$/
      @fund_allocations
    end
end