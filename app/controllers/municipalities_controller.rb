class MunicipalitiesController < InheritedResources::Base
  include ApplicationHelper

  actions :all, except: :show
  before_action :municipality_params, only: :show

  respond_to :html, :json

  has_scope :province_id, :with_year,:region_id, :with_id
  def create
    @municipality = Municipality.new(permitted_params[:municipality])
    if @municipality.save 
      flash[:success] = 'Updated Successfully.'
      redirect_to municipalities_path
    else
      flash[:error] = 'Failed to Update: Please Contact Administrator'
      redirect_to municipalities_path
    end


  end

  def show
    #@subprojects = apply_scopes(@municipality.subprojects)
    @subprojects = Subproject.where('EXTRACT( YEAR from date_of_mibf) = ? AND municipality_id = ?', params[:with_year], params[:id]).order("date_of_mibf")
    @subproject = Subproject.where('EXTRACT( YEAR from date_of_mibf) = ? AND municipality_id = ?', params[:with_year], params[:id]).last
    @cgdp = Cgdp.where('municipality_id =?', params[:id]).last

  end

  def update
    @municipality = Municipality.find(params[:id])
    if @municipality.update_attributes update_params
      flash[:success] = 'Updated Successfully.'
      redirect_to municipalities_path
    else
      flash[:error] = 'Failed to Update: Please Contact Administrator'
      redirect_to municipalities_path
    end
  end
  
  def update_fund_source
    @sp = Subproject.find(params[:subproject_id])
    @fs = FundSource.find(params[:fund_source_id])

    if @sp.status == "Final"
      @sp.update(fund_source_id: @fs.id)
    end     
  end

  def assigned_fund_source
    @sp = Subproject.find(params[:subproject_id])
    @id = params[:subproject_id]
    if @sp.status != "Final"
      @group = @sp.municipality.group
      if @group.present?
        if @group.code == "293"
          @fs = FundSource.where(code: "WB").first
          @sp.update(fund_source_id: @fs.id)
        elsif @group.code == "177"
          @fs = FundSource.where(code: "ADB").first
          @sp.update(fund_source_id: @fs.id)
        else
          
        end
      else
        # Condition in Assign Fundsource without group
        # @fs = FundSource.where(code: "ADB").first
        # @sp.update(fund_source_id: @fs.id)
      end
    end

  end

  def edit
    @municipality = Municipality.find(params[:id])
  end

  def edit_cgdp
    @subprojects = Subproject.where('EXTRACT( YEAR from date_of_mibf) = ? AND municipality_id = ?', params[:with_year], params[:id])
    @subproject = Subproject.where('EXTRACT( YEAR from date_of_mibf) = ? AND municipality_id = ?', params[:with_year], params[:id]).last
    @cgdp = Cgdp.find(params[:cgdp_id]) 
  end

  def create_cgdp
    @subprojects = Subproject.where('EXTRACT( YEAR from date_of_mibf) = ? AND municipality_id = ?', params[:with_year], params[:id])
    @subproject = Subproject.where('EXTRACT( YEAR from date_of_mibf) = ? AND municipality_id = ?', params[:with_year], params[:id]).last
    @cgdp = Cgdp.new 
  end

  protected
    def permitted_params
      params.permit(municipality: %i[province_id name group_id])
    end

    def collection
      @municipalities = apply_scopes(Municipality)
      @municipalities = @municipalities.paginate(page: params[:page]) unless request.url =~ /json/
      @municipalities
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
