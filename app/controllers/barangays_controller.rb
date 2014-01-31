class BarangaysController < ApplicationController
  respond_to :html, :json

  def index
    @barangays = Barangay.where(municipality_id: params[:municipality_id])
    respond_with @barangays
  end
end
