class ReportsController < ApplicationController

	%w[region province municipality barangay].each{ |e| has_scope "subproject_#{e}_id".intern }

	def soe_reports
		
	end

	def mga_reports

	end

	def cg_reports
		raise
	end

	def cash_program_reports

	end

	def download_file
		send_file 'public/sample_file.pdf', type: 'image/pdf', disposition: 'inline'	
	end	

end