class RequestForFundReleasesController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality barangay].each{ |e| has_scope "subproject_#{e}_id".intern }
  
  def index
    @rfrs = apply_scopes(RequestForFundRelease).includes(subproject:[:region, :province, :municipality, :barangay])
    #@rfrs = RequestForFundRelease.all
  end

  def select_subproject
    # @subprojects = apply_scopes(Subproject).eager_load(:region, :province, :municipality, :barangay)
    @subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality, :barangay)    
  end

  def new
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
    @rfrs = RequestForFundRelease.new
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'select_subproject'
  end

  def create
    @rfrs = RequestForFundRelease.new rfrs_params
    if @rfrs.save
      flash[:success] = 'Request for release created successfully.'
      redirect_to request_for_fund_releases_path
    else
      flash[:error] = 'An error occured while creating request'
      render 'new'
    end
  end

  protected

    def permitted_params
      params.permit(barangay: %i[
          municipality_id name 
          ])
    end

    def rfrs_params
      attrs = [
        :status, :subproject_id, :rfr_type, :request_date, :bank_account_number, :address, :branch, :city, :province, :phone,
        :amount_approve, :remarks, :obr_number, :obr_date, :dv_number,
        :dv_date, :check_number, :check_date, :account_name, :requested_by_first, :designation_first, :date_first,
        :requested_by_second, :designation_second, :date_second, :date_received, :reviewed_by_first, :reviewed_by_second,
        :rev_date_first, :rev_date_second, :rev_designation_first, :rev_designation_second, :srpmo_designation, :srpmo_date,
        :srpmo_date_received, :srpmo_reviewed_by, :srpmo_recommend_by, :srpmo_rec_designation, :srpmo_rec_date, :rpmo_designation,
        :rpmo_date, :rpmo_date_received, :rpmo_approved_by, :approved_as_requested ]
      params.require(:request_for_fund_release).permit(attrs)
    end
end