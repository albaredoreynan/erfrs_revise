class MunicipalitiesController < InheritedResources::Base
  actions :all, except: :show
  before_action :municipality_params, only: :show

  respond_to :html, :json

  has_scope :province_id, :with_year

  def show
    #@subprojects = apply_scopes(@municipality.subprojects)
    @subprojects = Subproject.where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ?', params[:with_year], params[:id])
    @subproject = Subproject.where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ?', params[:with_year], params[:id]).last
  end

  protected

    def permitted_params
      params.permit(municipality: %i[province_id name])
    end

    def collection
      @municipalities = apply_scopes(Municipality)
      @municipalities = @municipalities.paginate(page: params[:page]) unless request.url =~ /json$/
      @municipalities
    end

    private
      def municipality_params
        @municipality = Municipality.find(params[:id])
      end
end
