class ReportsController < ApplicationController
  before_filter :rfrs_control_data, only: [:soe_reports, :soe_adb_reports]
  before_filter :subproject_control_data, only: [:mga_reports, :cg_reports, :cash_program_reports]

	%w[region province municipality barangay].each{ |e| has_scope "#{e}_id".intern }
	%w[region province municipality barangay].each{ |e| has_scope "subproject_#{e}_id".intern}
	has_scope :start_year
	has_scope :end_year
	has_scope	:start_date
	has_scope :end_date
	has_scope :year
	has_scope :fund_source

  def soe_reports
		@soe = apply_scopes(@rfrs_data).includes(subproject:[:region, :province, :municipality, :barangay])
    respond_to do |format|
    	format.html
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
	end

	def mga_reports
		@subprojects = apply_scopes(@subproject_data).includes(:region, :province, :municipality).where(status: "Final").group_by(&:municipality)
		respond_to do |format|
    	format.html
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
      format.pdf do
        render :pdf => "mga_reports",
               :orientation => "Landscape"
      end
  	end
	end

	def cg_reports
		@subprojects = apply_scopes(@subproject_data).includes(:region, :province, :municipality).where(status: "Final").group_by(&:municipality)
		respond_to do |format|
    	format.html
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
      format.pdf do
        render :pdf => "cg_reports",
               :orientation => "Landscape"
      end
  	end
	end

	def cash_program_reports
		@subprojects = apply_scopes(@subproject_data).includes(:region, :province, :municipality).where(status: "Final").group_by(&:municipality)
    respond_to do |format|
      format.html
      format.xls
      format.pdf do
        render :pdf         => "Community Grants Disbursement Plan Report",
              :orientation  => 'Landscape',
              :page_width   => '13in'
      end
    end
	end

  def soe_adb_reports
    @soe = apply_scopes(@rfrs_data).includes(subproject:[:region, :province, :municipality, :barangay])
    respond_to do |format|
      format.html
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
    
  end


	def download_file
		send_file 'public/sample_file.pdf', type: 'image/pdf', disposition: 'inline'	
	end	

  def update_exchange_rate
    puts 'success enter'
    rfr= RequestForFundRelease.find(params[:rfrs_id].to_i)
    puts 'succes line 1'
    rfr.update(exchange_rate: params[:exchange_rate].to_i)
    puts 'success line 2'
  end

  def update_remark
    puts 'success enter'
    rfr= RequestForFundRelease.find(params[:rfrs_id].to_i)
    puts 'succes line 1'
    rfr.update(excel_remark: params[:remark])
    puts 'success line 2'
  end


  protected
    def soe_report_params
      params.permit(request_for_fund_release: %i[exchange_rate])
    end

    def rfrs_control_data 
      if current_user.role_id == 3 or current_user.role_id == 4
        rfrs = Subproject.where(region_id: current_user.region_id)
        subproject_id = rfrs.pluck(:id)
      elsif current_user.role_id == 5
        rfrs = Subproject.where(municipality_id: current_user.municipality_id)    
        subproject_id = rfrs.pluck(:id)
      elsif current_user.role_id == 6
        rfrs = Subproject.where(barangay_id: current_user.barangay_id)
        subproject_id = rfrs.pluck(:id)
      else
        rfrs = Subproject.all
        subproject_id = rfrs.pluck(:id)
      end
      @rfrs_data = RequestForFundRelease.where(subproject_id: subproject_id)
    end

    def subproject_control_data
      if current_user.role_id == 3 or current_user.role_id == 4
        @subproject_data = Subproject.where(region_id: current_user.region_id).order("region_id ASC")
      elsif current_user.role_id == 5
        @subproject_data = Subproject.where(municipality_id: current_user.municipality_id).order("region_id ASC")    
      elsif current_user.role_id == 6
        @subproject_data = Subproject.where(barangay_id: current_user.barangay_id).order("region_id ASC")
      else
        @subproject_data = Subproject.all.order("region_id ASC")
      end
    end



end
