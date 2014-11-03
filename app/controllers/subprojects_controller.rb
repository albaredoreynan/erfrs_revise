class SubprojectsController < ApplicationController


  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality barangay].each{ |e| has_scope "subproject_#{e}_id".intern }
  
  has_scope :fund_source_id

  before_action :define_total, only: %i[show edit new]

  def define_total
    @total = 0.0
  end

  def index
    usercode = current_user.role.code
    if usercode == 20 || usercode == 15
      subpro = Subproject.where(region_id: current_user.region_id)
    elsif usercode == 40
      subpro = Subproject.where(municipality_id: current_user.municipality_id)    
    elsif usercode == 50
      subpro = Subproject.where(barangay_id: current_user.barangay_id)
    else
      subpro = Subproject.all
    end

    @subprojects = apply_scopes(subpro).includes(
      :region, :province, :municipality, :barangay).order(created_at: :asc)
                                                   .sort!{ |a,b| a.barangay.name.downcase <=>  b.barangay.name.downcase }
                                                   .sort!{ |a,b| a.municipality.name.downcase <=>  b.municipality.name.downcase }
                                                   .sort!{ |a,b| a.province.name.downcase <=>  b.province.name.downcase }
                                                   .sort!{ |a,b| a.region.name.downcase <=>  b.region.name.downcase }
  end

  def show
    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find params[:id]
    @total = %w[first second third].reduce(0.0) do |sum, ordinal|
      sum += @subproject.send "#{ordinal}_tranch_amount"
    end
  end

  def new
    @subproject = Subproject.new
  end

  def edit
    @subproject = Subproject.find params[:id]
  end

  def create
    @subproject = Subproject.new subproject_params
    @subproject.user_id = current_user.id
    @subproject.date_encoded = DateTime.now.strftime("%d/%b/%Y")
    @subproject.grant_amount_direct_cost = subproject_params[:grant_amount_direct_cost].gsub(/,/, '').to_f
    @subproject.grant_amount_indirect_cost = subproject_params[:grant_amount_indirect_cost].gsub(/,/, '').to_f
    @subproject.grant_amount_contingency_cost = subproject_params[:grant_amount_contingency_cost].gsub(/,/, '').to_f
    @subproject.lcc_blgu_direct_cost = subproject_params[:lcc_blgu_direct_cost].gsub(/,/, '').to_f
    @subproject.lcc_blgu_indirect_cost = subproject_params[:lcc_blgu_indirect_cost].gsub(/,/, '').to_f
    @subproject.lcc_blgu_contingency_cost = subproject_params[:lcc_blgu_contingency_cost].gsub(/,/, '').to_f
    @subproject.community_direct_cost = subproject_params[:community_direct_cost].gsub(/,/, '').to_f
    @subproject.community_indirect_cost = subproject_params[:community_indirect_cost].gsub(/,/, '').to_f
    @subproject.community_contingency_cost = subproject_params[:community_contingency_cost].gsub(/,/, '').to_f
    @subproject.mlgu_direct_cost = subproject_params[:mlgu_direct_cost].gsub(/,/, '').to_f
    @subproject.mlgu_indirect_cost = subproject_params[:mlgu_indirect_cost].gsub(/,/, '').to_f
    @subproject.mlgu_contingency_cost = subproject_params[:mlgu_contingency_cost].gsub(/,/, '').to_f
    @subproject.plgu_others_direct_cost = subproject_params[:plgu_others_direct_cost].gsub(/,/, '').to_f
    @subproject.plgu_others_indirect_cost = subproject_params[:plgu_others_indirect_cost].gsub(/,/, '').to_f
    @subproject.plgu_others_contingency_cost = subproject_params[:plgu_others_contingency_cost].gsub(/,/, '').to_f
    @subproject.total_lcc_cash_direct_cost = subproject_params[:total_lcc_cash_direct_cost].gsub(/,/, '').to_f
    @subproject.total_lcc_cash_indirect_cost = subproject_params[:total_lcc_cash_indirect_cost].gsub(/,/, '').to_f
    @subproject.total_lcc_cash_contingency_cost = subproject_params[:total_lcc_cash_contingency_cost].gsub(/,/, '').to_f
    @subproject.total_lcc_in_kind_direct_cost = subproject_params[:total_lcc_in_kind_direct_cost].gsub(/,/, '').to_f
    @subproject.total_lcc_in_kind_indirect_cost = subproject_params[:total_lcc_in_kind_indirect_cost].gsub(/,/, '').to_f
    @subproject.total_lcc_in_kind_contingency_cost = subproject_params[:total_lcc_in_kind_contingency_cost].gsub(/,/, '').to_f
    @subproject.first_tranch_amount = subproject_params[:first_tranch_amount].gsub(/,/, '').to_f
    @subproject.second_tranch_amount = subproject_params[:second_tranch_amount].gsub(/,/, '').to_f
    @subproject.third_tranch_amount = subproject_params[:third_tranch_amount].gsub(/,/, '').to_f
    @subproject.first_tranch_revised_amount = subproject_params[:first_tranch_revised_amount].gsub(/,/, '').to_f if subproject_params[:first_tranch_revised_amount].present?
    @subproject.second_tranch_revised_amount = subproject_params[:second_tranch_revised_amount].gsub(/,/, '').to_f if subproject_params[:second_tranch_revised_amount].present?
    @subproject.third_tranch_revised_amount = subproject_params[:third_tranch_revised_amount].gsub(/,/, '').to_f if subproject_params[:third_tranch_revised_amount].present?

    if @subproject.save
      flash[:success] = 'Sub-Project created successfully.'
      redirect_to edit_subproject_path(@subproject.id)
    else
      flash[:error] = 'An error occured while creating project'
      render 'new'
    end
  end

  def update
    @subproject = Subproject.find params[:id]
    params[:subproject][:grant_amount_direct_cost] = subproject_params[:grant_amount_direct_cost].gsub(/,/, '').to_f
    params[:subproject][:grant_amount_indirect_cost] = subproject_params[:grant_amount_indirect_cost].gsub(/,/, '').to_f
    params[:subproject][:grant_amount_contingency_cost] = subproject_params[:grant_amount_contingency_cost].gsub(/,/, '').to_f
    params[:subproject][:lcc_blgu_direct_cost] = subproject_params[:lcc_blgu_direct_cost].gsub(/,/, '').to_f
    params[:subproject][:lcc_blgu_indirect_cost] = subproject_params[:lcc_blgu_indirect_cost].gsub(/,/, '').to_f
    params[:subproject][:lcc_blgu_contingency_cost] = subproject_params[:lcc_blgu_contingency_cost].gsub(/,/, '').to_f
    params[:subproject][:community_direct_cost] = subproject_params[:community_direct_cost].gsub(/,/, '').to_f
    params[:subproject][:community_indirect_cost] = subproject_params[:community_indirect_cost].gsub(/,/, '').to_f
    params[:subproject][:community_contingency_cost] = subproject_params[:community_contingency_cost].gsub(/,/, '').to_f
    params[:subproject][:mlgu_direct_cost] = subproject_params[:mlgu_direct_cost].gsub(/,/, '').to_f
    params[:subproject][:mlgu_indirect_cost] = subproject_params[:mlgu_indirect_cost].gsub(/,/, '').to_f
    params[:subproject][:mlgu_contingency_cost] = subproject_params[:mlgu_contingency_cost].gsub(/,/, '').to_f
    params[:subproject][:plgu_others_direct_cost] = subproject_params[:plgu_others_direct_cost].gsub(/,/, '').to_f
    params[:subproject][:plgu_others_indirect_cost] = subproject_params[:plgu_others_indirect_cost].gsub(/,/, '').to_f
    params[:subproject][:plgu_others_contingency_cost] = subproject_params[:plgu_others_contingency_cost].gsub(/,/, '').to_f
    params[:subproject][:total_lcc_cash_direct_cost] = subproject_params[:total_lcc_cash_direct_cost].gsub(/,/, '').to_f
    params[:subproject][:total_lcc_cash_indirect_cost] = subproject_params[:total_lcc_cash_indirect_cost].gsub(/,/, '').to_f
    params[:subproject][:total_lcc_cash_contingency_cost] = subproject_params[:total_lcc_cash_contingency_cost].gsub(/,/, '').to_f
    params[:subproject][:total_lcc_in_kind_direct_cost] = subproject_params[:total_lcc_in_kind_direct_cost].gsub(/,/, '').to_f
    params[:subproject][:total_lcc_in_kind_indirect_cost] = subproject_params[:total_lcc_in_kind_indirect_cost].gsub(/,/, '').to_f
    params[:subproject][:total_lcc_in_kind_contingency_cost] = subproject_params[:total_lcc_in_kind_contingency_cost].gsub(/,/, '').to_f
    params[:subproject][:first_tranch_amount] = subproject_params[:first_tranch_amount].gsub(/,/, '').to_f
    params[:subproject][:second_tranch_amount] = subproject_params[:second_tranch_amount].gsub(/,/, '').to_f
    params[:subproject][:third_tranch_amount] = subproject_params[:third_tranch_amount].gsub(/,/, '').to_f
    params[:subproject][:first_tranch_revised_amount] = subproject_params[:first_tranch_revised_amount].gsub(/,/, '').to_f
    params[:subproject][:second_tranch_revised_amount] = subproject_params[:second_tranch_revised_amount].gsub(/,/, '').to_f
    params[:subproject][:third_tranch_revised_amount] = subproject_params[:third_tranch_revised_amount].gsub(/,/, '').to_f
    
    if @subproject.update_attributes subproject_params
      flash[:success] = 'Sub-Project updated successfully.'
      redirect_to edit_subproject_path(@subproject)
    else
      flash[:error] = 'An error occured while updating project'
      render 'edit'
    end
  end

  def destroy

    @subproject = Subproject.find(params[:id])

    if @subproject.status != "Final"
      @subproject.destroy
      flash[:success] = 'Sub-Project was deleted successfully.'
    else
      flash[:alert] = "Sub-Project Cannot be deleted"
    end

    redirect_to subprojects_path
  end

  def display_group
    @municipality = Municipality.find(params[:municipality_id])
    @group = @municipality.group
  end

  protected

  def subproject_params
    attrs = [
      # general information
      :status, # const lookup
      :title,
      :region_id,
      :province_id,
      :municipality_id,
      :barangay_id,
      :category, # cost lookup
      :physical_target, # const lookup
      :cost_parameter, # const lookup
      :mode_of_implementation, # const_lookup
      :description,
      :fund_source_id,
      :cycle,
      :date_of_mibf,
      :date_encoded,
      # financial information
      :grant_amount_direct_cost,
      :grant_amount_indirect_cost,
      :grant_amount_contingency_cost,
      :lcc_blgu_direct_cost,
      :lcc_blgu_indirect_cost,
      :lcc_blgu_contingency_cost,
      :community_direct_cost,
      :community_indirect_cost,
      :community_contingency_cost,
      :mlgu_direct_cost,
      :mlgu_indirect_cost,
      :mlgu_contingency_cost,
      :plgu_others_direct_cost,
      :plgu_others_indirect_cost,
      :plgu_others_contingency_cost,
      :total_lcc_cash_direct_cost,
      :total_lcc_cash_indirect_cost,
      :total_lcc_cash_contingency_cost,
      :total_lcc_in_kind_direct_cost,
      :total_lcc_in_kind_indirect_cost,
      :total_lcc_in_kind_contingency_cost,
      # projected schedule of grant fund releases
      :first_tranch_amount,
      :first_tranch_date_required,
      :second_tranch_amount,
      :second_tranch_date_required,
      :third_tranch_amount,
      :third_tranch_date_required,
      :first_tranch_revised_amount,
      :second_tranch_revised_amount,
      :third_tranch_revised_amount,
      :tranch_one_percentage,
      :tranch_two_percentage,
      :tranch_three_percentage,
      # team member params
      team_members_attributes: [:id, :name, :designation_id, :email, :phone]
    ]
    params.require(:subproject).permit(attrs)
  end
end
