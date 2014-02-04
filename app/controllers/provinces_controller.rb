class ProvincesController < InheritedResources::Base
  actions :all, except: :show

  respond_to :html, :json

  has_scope :region_id

  protected

    def permitted_params
      params.permit(province: %i[region_id name])
    end

    def collection
      @provinces = apply_scopes(Province)
      @provinces = @provinces.paginate(page: params[:page]) unless request.url =~ /json$/
    end
end
