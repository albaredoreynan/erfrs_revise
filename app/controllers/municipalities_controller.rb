class MunicipalitiesController < ApplicationController
  respond_to :html, :json

  def index
    @municipalities = Municipality.where(province_id: params[:province_id])
    respond_with @municipalities
  end
end
