class MunicipalitiesController < InheritedResources::Base
  actions :all, except: :show

  respond_to :html, :json

  has_scope :province_id

  protected

    def permitted_params
      params.permit(municipality: %i[province_id name])
    end

    def collection
      @municipalities = apply_scopes(Municipality)
      @municipalities = @municipalities.paginate(page: params[:page]) unless request.url =~ /json$/
      @municipalities
    end
end
