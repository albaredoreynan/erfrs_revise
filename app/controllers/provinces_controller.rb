class ProvincesController < ApplicationController
  respond_to :html, :json

  actions :all, except: :show

  def permitted_params
    params.permit(province: %i[region_id name])
  end
end
