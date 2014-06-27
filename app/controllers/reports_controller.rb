class ReportsController < ApplicationController

	%w[region province municipality barangay].each{ |e| has_scope "#{e}_id".intern }
	%w[region province municipality barangay].each{ |e| has_scope "subproject_#{e}_id".intern }
	has_scope :start_year
	has_scope :end_year
	has_scope	:start_date
	has_scope :end_date
	has_scope :year
	has_scope :fund_source
	def soe_reports
		@soe = apply_scopes(RequestForFundRelease).includes(subproject:[:region, :province, :municipality, :barangay])
		respond_to do |format|
    	format.html
    	format.xls # { send_data @products.to_csv(col_sep: "\t") }
  	end
	end

	def mga_reports
		@subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).where(status: "Final").group_by(&:municipality)
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
		@subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).where(status: "Final").group_by(&:municipality)
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
		@subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).where(status: "Final").group_by(&:municipality)
    respond_to do |format|
      format.html
      format.pdf do
        render :pdf         => "Community Grants Disbursement Plan Report",
              :orientation  => 'Landscape',
              :page_width   => '13in'
      end
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

  protected
    def soe_report_params
      params.permit(request_for_fund_release: %i[exchange_rate])
    end
end
