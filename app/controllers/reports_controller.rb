class ReportsController < ApplicationController

	def soe_reports
		
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