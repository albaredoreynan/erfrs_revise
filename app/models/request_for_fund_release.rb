class RequestForFundRelease < ActiveRecord::Base
  belongs_to :subproject

  validates_presence_of :obr_number, :if => :confirm_presence_of_obr_date?, :message => "test 123"
  validates_presence_of :obr_date, :if => :confirm_presence_of_obr_number?, :message => "test 456"

  def confirm_presence_of_obr_date?
  	obr_date.nil?
  end

	def confirm_presence_of_obr_number?
  	obr_number.nil?
  end  
end
