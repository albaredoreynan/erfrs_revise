class ReportsController < ApplicationController

	%w[region province municipality barangay].each{ |e| has_scope "#{e}_id".intern }
	has_scope :start_year
	has_scope :end_year
	has_scope	:start_date
	has_scope :end_date
	def soe_reports
		@soe = apply_scopes(RequestForFundRelease).includes(subproject:[:region, :province, :municipality, :barangay])
	end

	def mga_reports

	end

	def cg_reports

	end

	def cash_program_reports

	end

	def download_file
		send_file 'public/sample_file.pdf', type: 'image/pdf', disposition: 'inline'	
	end	

end