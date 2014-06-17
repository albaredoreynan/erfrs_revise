class RegionalOfficersController < ApplicationController
  #before_action :set_region

  has_scope :region_id
  #has_scope :ro_type

  def index
    @regional_officers = apply_scopes(RegionalOfficer).all
  end

  private
    def set_region
      @region = Region.find(params[:region_id])
    end

end
