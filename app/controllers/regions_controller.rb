class RegionsController < ApplicationController
  respond_to :html, :json

  inherit_resources

  actions :all, except: :show

  def permitted_params
    params.permit(region: %i[code name for_regional_accounting for_management_division_head for_regional_director for_asst_regional_director_opt for_asst_regional_director_adm for_budget_officer address_region])
  end
end
