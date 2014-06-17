class RegionalOfficersController < ApplicationController

  has_scope :region_id
  #has_scope :ro_type

  def index
    @regional_officers = apply_scopes(RegionalOfficer).all
  end

end
