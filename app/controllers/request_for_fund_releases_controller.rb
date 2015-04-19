class RequestForFundReleasesController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality barangay].each{ |e| has_scope "#{e}_id".intern }
  has_scope :rfr_id
  has_scope :sp_id
  has_scope :username
  has_scope :with_status
  respond_to :js, only: :new

  def index
    usercode = current_user.role.code
    if usercode == 20 || usercode == 15
      rfrs = Subproject.where(region_id: current_user.region_id)
      subproject_id = rfrs.pluck(:id)
    elsif usercode == 40
      rfrs = Subproject.where(municipality_id: current_user.municipality_id)    
      subproject_id = rfrs.pluck(:id)
    elsif usercode == 50
      rfrs = Subproject.where(barangay_id: current_user.barangay_id)
      subproject_id = rfrs.pluck(:id)
    else
      rfrs = Subproject.all
      subproject_id = rfrs.pluck(:id)
    end
    
    rfrs_data = RequestForFundRelease.where(subproject_id: subproject_id).paginate(page: params[:page], per_page: 30).order(created_at: :asc)
    @rfrs = apply_scopes(rfrs_data).includes(subproject:[:region, :province, :municipality, :barangay])
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
    if params[:sp_id].present?
      @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
    else
      @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(@rfrs.subproject_id)
    end
    @team_member = @subproject.team_members
    if !@team_member.present? 
      @team_member = TeamMember.all
    else
      @team_member = @team_member
    end
  end

  def show
    @rfrs = RequestForFundRelease.find params[:id]
    if params[:sp_id].nil?
      params[:sp_id] = @rfrs.subproject_id
    end
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
  end

  def update
    @rfrs = RequestForFundRelease.find params[:id]
    @subproj = Subproject.find rfrs_params[:subproject_id]
    params[:request_for_fund_release][:amount_approve] = rfrs_params[:amount_approve].gsub(/,/, '').to_f
    rfrs_params[:amount_approve] = rfrs_params[:amount_approve].gsub(/,/, '').to_f 
    # raise
    # params[:request_for_fund_release][:amount_requested] = rfrs_params[:amount_requested]
    if @rfrs.update_attributes rfrs_params
      if rfrs_params[:tranch_for] == '1'
        @subproj.update(first_tranch_amount_release: params[:request_for_fund_release][:amount_approve], first_tranch_revised_amount: params[:request_for_fund_release][:amount_approve])
      elsif rfrs_params[:tranch_for] == '2'
        @subproj.update(second_tranch_amount_release: params[:request_for_fund_release][:amount_approve], second_tranch_revised_amount: params[:request_for_fund_release][:amount_approve])
      else  
        @subproj.update(third_tranch_amount_release: params[:request_for_fund_release][:amount_approve], third_tranch_revised_amount: params[:request_for_fund_release][:amount_approve])
      end 
      flash[:success] = 'Request for release updated successfully.'
      redirect_to edit_request_for_fund_release_path(@rfrs, :sp_id => @subproj.id)
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
    # @rfrs.amount_requested = rfrs_params[:amount_requested].gsub(/,/, '').to_f
    @rfrs.amount_approve = rfrs_params[:amount_approve].gsub(/,/, '').to_f
    if @rfrs.save 
      if rfrs_params[:tranch_for] == '1'
        @subproj.update(first_tranch_amount_release: rfrs_params[:amount_approve].gsub(/,/, '').to_f, first_tranch_revised_amount: rfrs_params[:amount_approve].gsub(/,/, '').to_f)
      elsif rfrs_params[:tranch_for] == '2'
        @subproj.update(second_tranch_amount_release: rfrs_params[:amount_approve].gsub(/,/, '').to_f, second_tranch_revised_amount: rfrs_params[:amount_approve].gsub(/,/, '').to_f)
      else  
        @subproj.update(third_tranch_amount_release: rfrs_params[:amount_approve].gsub(/,/, '').to_f, third_tranch_revised_amount: rfrs_params[:amount_approve].gsub(/,/, '').to_f)
      end 
      flash[:success] = 'Request for release created successfully.'
      # redirect_to request_for_fund_releases_path
      redirect_to subproject_path(@subproj)
    else
      flash[:error] = 'An error occured while creating request'
      redirect_to new_request_for_fund_release_path(:sp_id => @subproj.id, :tranch => tranch(@subproj))
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
    @rfr_signatory = RfrSignatory.new
    @positions = RfrSignatory.where(request_for_fund_release_id: params[:rfrs_id], group: "A", sign_type: "OR")
    @positions2 = RfrSignatory.where(request_for_fund_release_id: params[:rfrs_id], group: "B", sign_type: "OR")
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf         => "ObR",
              :orientation  => 'Portrait',
              :page_width   => '13in',
              :margin => {:top       => 0,
                           :bottom   => 4}
      end
    end
  end


  def dv
    @rfrs = RequestForFundRelease.find params[:rfrs_id]
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
    @rfr_signatory = RfrSignatory.new
    @positions = RfrSignatory.where(request_for_fund_release_id: params[:rfrs_id], group: "A", sign_type: "DV")
    @positions2 = RfrSignatory.where(request_for_fund_release_id: params[:rfrs_id], group: "B", sign_type: "DV")
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf         => "DV",
              :orientation  => 'Portrait',
              :page_width   => '13in',
              :margin => {:top       => 0,
                           :bottom   => 4}
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
              :page_width   => '13in',
              :margin => {:top       => 0,
                           :bottom   => 4}
      end
    end
  end

  def rfr_signatory
    # @rfr_signatory = RfrSignatory.new rfr_signatory_params
    @rfrs_signatories = rfr_signatory_params[:rfr_signatory]
    @ids = params[:rfr_signatory][:regional_officer_id]
    @ids.each do |rsid|
      RfrSignatory.create!(@rfrs_signatories.merge(regional_officer_id: rsid))
    end
    if params[:came_from] == 'obr' 
      redirect_to obr_request_for_fund_releases_path(:rfrs_id => params[:rfr_signatory][:request_for_fund_release_id], :sp_id => params[:sp_id])
    else
      redirect_to dv_request_for_fund_releases_path(:rfrs_id => params[:rfr_signatory][:request_for_fund_release_id], :sp_id => params[:sp_id])
    end
  end 

  def remove_signatory
    @rfr_signatory = RfrSignatory.find(params[:id])
    @rfr_signatory.destroy!
    if params[:type] == 'obr'
      redirect_to obr_request_for_fund_releases_path(:rfrs_id => params[:rfrs_id], :sp_id => params[:sp_id])
    else
      redirect_to dv_request_for_fund_releases_path(:rfrs_id => params[:rfrs_id], :sp_id => params[:sp_id])
    end
  end

  private
    def tranch(subproject)
      if subproject.first_tranch_amount_release == 0
        tranch = 'first'
      elsif subproject.first_tranch_amount_release != 0 && subproject.second_tranch_amount_release == 0
        tranch = 'second'
      elsif subproject.first_tranch_amount_release != 0 && subproject.second_tranch_amount_release != 0 && subproject.third_tranch_amount_release == 0
        tranch = 'third'
      else
        tranch = 'other'      
      end
      return tranch
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
        :rpmo_date, :rpmo_date_received, :rpmo_approved_by, :approved_as_requested, :tranch_for, :amount_requested, :amount_contingency ]
      params.require(:request_for_fund_release).permit(attrs)
    end

    def rfr_signatory_params
      # params.require(:rfr_signatory).permit( {:regional_officer_id, :request_for_fund_release_id)
      params.permit(rfr_signatory: [:request_for_fund_release_id, :regional_officer_id, :group, :sign_type ])  
    end
end
