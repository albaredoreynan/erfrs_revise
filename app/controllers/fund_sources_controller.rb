class FundSourcesController < InheritedResources::Base
	actions :all, except: :show
  
  respond_to :html, :json

  protected

    def permitted_params
      params.permit(fund_source: %i[code name])
    end

    def collection
      @fund_sources = apply_scopes(FundSource)
      @fund_sources = @fund_sources.paginate(page: params[:page]) unless request.url =~ /json$/
      @fund_sources
    end
end