class ProvincesController < ApplicationController
  respond_to :html, :json

  def index
    @provinces = Province.where(region_id: params[:region_id])
    respond_with @provinces
  end
end
