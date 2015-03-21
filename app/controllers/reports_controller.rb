class ReportsController < ApplicationController
  before_filter :rfrs_control_data, only: [:soe_reports, :soe_adb_reports]
  before_filter :rfrs_tracking_data, only: [:rfrs_tracking_reports]
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
		@soe = apply_scopes(@rfrs_data).includes(subproject:[:region, :province, :municipality, :barangay, :fund_source]).where('fund_sources.code' => "WB")

    respond_to do |format|
    	format.html
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
	end

	def mga_reports
    # year =  params[:year].present? ?  params[:year].to_i : DateTime.now.year 
		# @subprojects = apply_scopes(@subproject_data).includes(:region, :province, :municipality, :request_for_fund_releases).where(status: "Final").reject { |sp| sp.with_draft_null_status_rfrs? }.group_by(&:municipality)
    sub_id= RequestForFundRelease.where(status: "Final").pluck(:subproject_id).uniq
    @subprojects = apply_scopes(@subproject_data).includes(:request_for_fund_releases, :region, :municipality)
                                                 .where('request_for_fund_releases.status' => "Final")
                                                 .order("region_id ASC")
                                                 .group_by(&:municipality)

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
		@subprojects = apply_scopes(@subproject_data).includes(:request_for_fund_releases, :region, :municipality)
                                                 .where('request_for_fund_releases.status' => "Final")
                                                 .order("region_id ASC")
                                                 .group_by(&:municipality)
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
		@subprojects = apply_scopes(@subproject_data).includes(:request_for_fund_releases, :region, :municipality)
                                                 .where('request_for_fund_releases.status' => "Final")
                                                 .order("region_id ASC")
                                                 .group_by(&:municipality)
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
    @soe = apply_scopes(@rfrs_data).includes(subproject:[:region, :province, :municipality, :barangay, :fund_source]).where('fund_sources.code' => "ADB")
    respond_to do |format|
      format.html
      format.xls # { send_data @products.to_csv(col_sep: "\t") }
    end
    
  end

  def rfrs_tracking_reports
    @rfrs = apply_scopes(@rfrs_tracking_data).includes(subproject:[:region, :province, :municipality, :barangay, :fund_source])
    respond_to do |format|
      format.html
      #format.xls # { send_data @products.to_csv(col_sep: "\t") }
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
      if params[:action] == "soe_adb_reports"
        fund_source = FundSource.where(code: "ADB").last.id
      else
        fund_source = FundSource.where(code: "WB").last.id
      end 
      
      if current_user.role_id == 3 or current_user.role_id == 4
        rfrs = Subproject.where(region_id: current_user.region_id, status: "Final", fund_source_id: fund_source)
        subproject_id = rfrs.pluck(:id)
      elsif current_user.role_id == 5
        rfrs = Subproject.where(municipality_id: current_user.municipality_id, status: "Final", fund_source_id: fund_source)    
        subproject_id = rfrs.pluck(:id)
      elsif current_user.role_id == 6
        rfrs = Subproject.where(barangay_id: current_user.barangay_id, status: "Final", fund_source_id: fund_source)
        subproject_id = rfrs.pluck(:id)
      else
        rfrs = Subproject.where(status: "Final", fund_source_id: fund_source)
        subproject_id = rfrs.pluck(:id)
      end
      @rfrs_data = RequestForFundRelease.where(subproject_id: subproject_id, status: "Final")
    end
   
    def rfrs_tracking_data
      if current_user.role_id == 3 or current_user.role_id == 4
        subprojects = Subproject.where(region_id: current_user.region_id, status: "Final")
        subproject_ids = subprojects.pluck(:id)
      elsif current_user.role_id == 5
        subprojects = Subproject.where(municipality_id: current_user.municipality_id, status: "Final")    
        subproject_ids = subprojects.pluck(:id)
      elsif current_user.role_id == 6
        subprojects = Subproject.where(barangay_id: current_user.barangay_id, status: "Final")
        subproject_ids = subprojects.pluck(:id)
      else
        subprojects = Subproject.where(status: "Final")
        subproject_ids = subprojects.pluck(:id)
      end
      @rfrs_tracking_data = RequestForFundRelease.where(subproject_id: subproject_ids, status: "Final")
    end 
  
    def subproject_control_data
      if current_user.role_id == 3 or current_user.role_id == 4
        @subproject_data = Subproject.where(region_id: current_user.region_id, status: "Final").order("region_id ASC")
      elsif current_user.role_id == 5
        @subproject_data = Subproject.where(municipality_id: current_user.municipality_id, status: "Final").order("region_id ASC")    
      elsif current_user.role_id == 6
        @subproject_data = Subproject.where(barangay_id: current_user.barangay_id, status: "Final").order("region_id ASC")
      else
        @subproject_data = Subproject.where(status: "Final")
      end
    end

end
