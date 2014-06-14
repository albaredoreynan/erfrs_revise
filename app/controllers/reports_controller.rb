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
	end

	def mga_reports
		@subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).group_by(&:municipality)
	end

	def cg_reports
		@subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).group_by(&:municipality)
	end

	def cash_program_reports
		@subprojects = apply_scopes(Subproject).includes(:region, :province, :municipality).group_by(&:municipality)
	end

	def download_file
		send_file 'public/sample_file.pdf', type: 'image/pdf', disposition: 'inline'	
	end	

end