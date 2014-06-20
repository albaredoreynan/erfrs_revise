class CgdpsController < ApplicationController

  %w[id user year status].each{ |e| has_scope "with_#{e}".intern }
  %w[region province municipality].each{ |e| has_scope "subproject_#{e}_id".intern }

  def index
    @subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).group_by(&:municipality)
    @cgdp = 0
  end

  def new 
  	@cgdp = Cgdp.new
  end

  def create
  	@cgdp = Cgdp.new permitted_params
  	if @cgdp.save 
      flash[:success] = 'Cgdp for this municipality created successfully.'
      redirect_to "#{municipality_path(permitted_params[:cgdp][:municipality_id])}?with_year=#{permitted_params[:cgdp][:year]}"

    else
      flash[:error] = 'An error occured while creating cgdp'
      render 'new'
    end
  end

  protected
  	def permitted_params
  		params.require(:cgdp).permit(:municipality_id, :year, :status, :saa_number, :saa_date)
  	end

end
