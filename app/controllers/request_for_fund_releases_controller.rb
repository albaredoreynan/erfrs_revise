class RequestForFundReleasesController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality barangay].each{ |e| has_scope "subproject_#{e}_id".intern }
  
  def index
  end
  
  def show
  end

  def new
    @subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality, :barangay)
  end

end
