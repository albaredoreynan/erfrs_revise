class SubprojectsController < ApplicationController
  def index
    @subprojects = Subproject.all
  end

  def show
    @subproject = Subproject.find params[:id]
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
      redirect_to subprojects_path, notice: 'Subproject created successfully'
    else
      flash[:error] = 'An error occured while creating project'
      render 'new'
    end
  end

  def update
    @subproject = Subproject.find params[:id]
    if @subproject.update_attributes subproject_params
      redirect_to subprojects_path, notice: 'Subproject updated successfully'
    else
      flash[:error] = 'An error occured while updating project'
      render 'edit'
    end
  end

  def destroy
    Subproject.find(params[:id]).destroy
    redirect_to subproject_paths, notie: 'Subproject was deleted successfully'
  end

  private

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
        # financial information
        :grant_amount_direct_cost,
        :grant_amount_indirect_cost,
        :lcc_blgu_direct_cost,
        :lcc_blgu_indirect_cost,
        :community_direct_cost,
        :community_indirect_cost,
        :mlgu_direct_cost,
        :mlgu_indirect_cost,
        :plgu_others_direct_cost,
        :plgu_others_indirect_cost,
        :total_lcc_cash_direct_cost,
        :total_lcc_cash_indirect_cost,
        :total_lcc_in_kind_direct_cost,
        :total_lcc_in_kind_indirect_cost,
        # projected schedule of grant fund releases
        :first_tranch_amount,
        :first_tranch_date_required,
        :second_tranch_amount,
        :second_tranch_date_required,
        :third_tranch_amount,
        :third_tranch_date_required,
        # team member params
        team_members_attributes: [:name, :designation, :email, :phone]
      ]
      params.require(:subproject).permit(attrs)
    end
end
