class RequestForFundRelease < ActiveRecord::Base
  belongs_to :subproject
  # TODO fix relationship to disregard requested_by_first_designation
  # belongs_to :requested_by_first, class_name: 'TeamMember', foreign_key: "requested_by_first"


  validates_presence_of :obr_number, :if => :confirm_presence_of_obr_date?, :message => "test 123"
  validates_presence_of :obr_date, :if => :confirm_presence_of_obr_number?, :message => "test 456"


  %w{region province municipality barangay}.each do |place|
    scope "#{place}_id".intern, -> place_id { joins(:subproject).where "subprojects.#{place}_id" => place_id }
  end

  scope :start_year, -> year {where("dv_date >= ?", Date.new(year.to_i).beginning_of_year)}
  scope :end_year, -> year {where("dv_date <= ?", Date.new(year.to_i).end_of_year)}

  # scope :upcoming, lambda {
  # where("start_date between ? and ?", Date.today, Date.today.next_month.beginning_of_month) }


  def confirm_presence_of_obr_date?
  	obr_date.nil?
  end

	def confirm_presence_of_obr_number?
  	obr_number.nil?
  end  
end
