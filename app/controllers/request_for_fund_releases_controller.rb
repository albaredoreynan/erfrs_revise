class RequestForFundReleasesController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality barangay].each{ |e| has_scope "subproject_#{e}_id".intern }
  
  def index
    @rfrs = apply_scopes(RequestForFundRelease).includes(subproject:[:region, :province, :municipality, :barangay])
  end

  def select_subproject
    @subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality, :barangay)    
  end

  def new

    @subproject = Subproject.includes(:region, :province, :municipality, :barangay).find(params[:sp_id].to_i)
    @rfrs = RequestForFundRelease.new
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'select_subproject'
  end

end
