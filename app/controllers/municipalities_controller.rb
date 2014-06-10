class MunicipalitiesController < InheritedResources::Base
  actions :all, except: :show
  before_action :municipality_params, only: :show

  respond_to :html, :json

  has_scope :province_id, :with_year,:region_id, :with_id

  def show
    #@subprojects = apply_scopes(@municipality.subprojects)
    @subprojects = Subproject.where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ?', params[:with_year], params[:id])
    @subproject = Subproject.where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ?', params[:with_year], params[:id]).last
  end

  def update
    @municipality = Municipality.find(params[:id])
    if @municipality.update_attributes update-params
      flash[:success] = 'Updated Successfully.'
      redirect_to municipalities_path
    else
      flash[:error] = 'Failed to Update: Please Contact Administrator'
      redirect_to municipalities_path
    end
  end

  protected

    def permitted_params
      params.permit(municipality: %i[province_id name group_id])
    end

    def collection
      @municipalities = apply_scopes(Municipality)
      @municipalities = @municipalities.paginate(page: params[:page]) unless request.url =~ /json$/
    end

    def update_params
      attrs = [:group_id, :name, :province_id]
      params.require(:municipality).permit(attrs) 
    end

  private
    def municipality_params
      @municipality = Municipality.find(params[:id])
    end
end
