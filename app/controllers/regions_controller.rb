class RegionsController < ApplicationController
  respond_to :html, :json

  inherit_resources

  actions :all, except: :show

  def permitted_params
    params.permit(region: %i[code name])
  end
end
