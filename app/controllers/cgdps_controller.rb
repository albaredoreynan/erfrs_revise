class CgdpsController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality].each{ |e| has_scope "subproject_#{e}_id".intern }

  def index
    @subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).where(status: "Final").group_by(&:municipality)
    @cgdp = Cgdp.where('municipality_id =?', params[:id]).last
  end

  def new 
  	@cgdp = Cgdp.new
  end

  def edit
  	@subprojects = Subproject.where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ?', params[:with_year], params[:id])
    @subproject = Subproject.where('EXTRACT( YEAR from created_at) = ? AND municipality_id = ?', params[:with_year], params[:id]).last
    @cgdp = Cgdp.find params[:id]
  end

  def create
  	# if permitted_params[:cgdp][:municipality_id]
  	@cgdp = Cgdp.new permitted_params
  	if @cgdp.save 
      flash[:success] = 'Cgdp for this municipality created successfully.'
      redirect_to cgdps_path
    else
      flash[:error] = 'An error occured while creating cgdp'
      redirect_to cgdps_path
    end
  end

  def update
  	@cgdp = Cgdp.find params[:id]
  	if @cgdp.update_attributes permitted_params
      flash[:success] = 'Cgdp for this municipality updated successfully.'
      redirect_to cgdps_path
    else
      flash[:error] = 'An error occured while updating cgdp'
      redirect_to cgdps_path
    end
  end

  protected
  	def permitted_params
  		params.require(:cgdp).permit(:municipality_id, :year, :status, :saa_number, :saa_date)
  	end

end
