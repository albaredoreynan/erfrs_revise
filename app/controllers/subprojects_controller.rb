class SubprojectsController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality barangay].each{ |e| has_scope "subproject_#{e}_id".intern }

  before_action :define_total, only: %i[show edit new]

  def define_total
    @total = 0.0
  end

  def index
    @subprojects = apply_scopes(Subproject).includes(
      :region, :province, :municipality, :barangay)
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
    if @subproject.save
      flash[:success] = 'Subproject created successfully.'
      redirect_to subprojects_path
    else
      flash[:error] = 'An error occured while creating project'
      render 'new'
    end
  end

  def update
    @subproject = Subproject.find params[:id]
    if @subproject.update_attributes subproject_params
      flash[:success] = 'Subproject updated successfully.'
      redirect_to subprojects_path
    else
      flash[:error] = 'An error occured while updating project'
      render 'edit'
    end
  end

  def destroy
    Subproject.find(params[:id]).destroy
    flash[:success] = 'Subproject was deleted successfully.'
    redirect_to subprojects_path
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
      :date_of_mbif,
      # financial information
      :grant_amount_direct_cost,
      :grant_amount_indirect_cost,
      :grant_amount_contingency_cost,
      :lcc_blgu_direct_cost,
      :lcc_blgu_indirect_cost,
      :lcc_contingency_cost,
      :community_direct_cost,
      :community_indirect_cost,
      :community_contingency_cost,
      :mlgu_direct_cost,
      :mlgu_indirect_cost,
      :mlgu_contingency_cost,
      :plgu_others_direct_cost,
      :plgu_others_indirect_cost,
      :plgu_contingency_cost,
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
      # team member params
      team_members_attributes: [:id, :name, :designation, :email, :phone]
    ]
    params.require(:subproject).permit(attrs)
  end
end
