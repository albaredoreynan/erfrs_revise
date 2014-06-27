class RequestForFundReleasesController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality barangay].each{ |e| has_scope "#{e}_id".intern }
  
  respond_to :js, only: :new

  def index
    @rfrs = apply_scopes(RequestForFundRelease).includes(subproject:[:region, :province, :municipality, :barangay])
    #@rfrs = RequestForFundRelease.all
  end

  def select_subproject
    # @subprojects = apply_scopes(Subproject).eager_load(:region, :province, :municipality, :barangay)
    @subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality, :barangay)    
  end

  def new
    subproject = Subproject.find(params[:sp_id])
    flash[:error] = 'You cannot create Request For Fund Release' if subproject.status != "Final"
    redirect_to subproject_path(params[:sp_id]) if subproject.status != "Final"
    @team_member = subproject.team_members
    if !@team_member.present? 
      @team_member = TeamMember.all
    else
      @team_member = @team_member
    end

    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
    @rfrs = RequestForFundRelease.new
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'select_subproject'
    
  end

  def edit
    @rfrs = RequestForFundRelease.find params[:id]
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
    @team_member = @subproject.team_members
    if !@team_member.present? 
      @team_member = TeamMember.all
    else
      @team_member = @team_member
    end
  end

  def show
    @rfrs = RequestForFundRelease.find params[:id]
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
  end

  def update
    @rfrs = RequestForFundRelease.find params[:id]
    @subproj = Subproject.find rfrs_params[:subproject_id]
    if @rfrs.update_attributes rfrs_params
      if rfrs_params[:tranch_for] == '1'
        @subproj.update(first_tranch_amount_release: rfrs_params[:amount_approve], first_tranch_revised_amount: rfrs_params[:amount_approve])
      elsif rfrs_params[:tranch_for] == '2'
        @subproj.update(second_tranch_amount_release: rfrs_params[:amount_approve], second_tranch_revised_amount: rfrs_params[:amount_approve])
      else  
        @subproj.update(third_tranch_amount_release: rfrs_params[:amount_approve], third_tranch_revised_amount: rfrs_params[:amount_approve])
      end 
      flash[:success] = 'Request for release updated successfully.'
      redirect_to edit_request_for_fund_release_path(@rfrs)
    else
      flash[:error] = 'An error occured while updating project'
      render 'edit'
    end
  end

  def create

    @rfrs = RequestForFundRelease.new rfrs_params
    @subproj = Subproject.find rfrs_params[:subproject_id]
    flash[:error] = 'You cannot create Request For Fund Release' if @subproj.status != "Final"
    redirect_to subproject_path(params[:sp_id]) if @subproj.status != "Final"
    #For safety purpose
    if @rfrs.save 
      if rfrs_params[:tranch_for] == '1'
        @subproj.update(first_tranch_amount_release: rfrs_params[:amount_approve], first_tranch_revised_amount: rfrs_params[:amount_approve])
      elsif rfrs_params[:tranch_for] == '2'
        @subproj.update(second_tranch_amount_release: rfrs_params[:amount_approve], second_tranch_revised_amount: rfrs_params[:amount_approve])
      else  
        @subproj.update(third_tranch_amount_release: rfrs_params[:amount_approve], third_tranch_revised_amount: rfrs_params[:amount_approve])
      end 
      flash[:success] = 'Request for release created successfully.'
      # redirect_to request_for_fund_releases_path
      redirect_to subproject_path(@subproj)
    else
      flash[:error] = 'An error occured while creating request'
      render 'new'
    end
  end

  def destroy
    @rfrs = RequestForFundRelease.find params[:id]

    @rfrs.destroy!
    flash[:success] = 'Request has been deleted.'
    redirect_to subproject_path(params[:sp_id])
  end

  def display_designation
    @team_member = TeamMember.find(params[:team_member]) 
    @designation_name = @team_member.designation.name
    @designation_position = params[:designation_position]
  end

  def obr
    @rfrs = RequestForFundRelease.find params[:rfrs_id]
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf         => "ObR",
              :orientation  => 'Portrait',
              :page_width   => '13in'
      end
    end
  end

  def dv
    @rfrs = RequestForFundRelease.find params[:rfrs_id]
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf         => "DV",
              :orientation  => 'Portrait',
              :page_width   => '13in'
      end
    end
  end


  def request_for_fund_pdf
    @rfrs = RequestForFundRelease.find params[:rfrs_id]
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id])
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf         => "Request_for_Fund_Release",
              :orientation  => 'Portrait',
              :page_width   => '13in'
      end
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
        :rpmo_date, :rpmo_date_received, :rpmo_approved_by, :approved_as_requested, :tranch_for ]
      params.require(:request_for_fund_release).permit(attrs)
    end
end