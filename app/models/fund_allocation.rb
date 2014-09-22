class FundAllocation < ActiveRecord::Base
  include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller.current_user }
  
	belongs_to :fund_source
  # validates :start_date, :end_date, :fund_source_id, presence: true
  # validate :not_overlap, scope: :fund_source_id



  ############################# Custom Validations##############################
  scope :overlaps, ->(start_date, end_date) do
    where "start_date between ? and ?", start_date, end_date
    where "end_date between ? and ?", start_date, end_date 
  end
  
  def overlaps?
    overlaps.exists?
  end

  def overlaps
    siblings.overlaps start_date, end_date
  end

  def not_overlap
    errors.add(:alert, 'Overlapping of dates found') if overlaps?
  end
  def siblings
    fund_source.fund_allocations.where('id != ?', id || -1)
  end

  ###############################################################################
end
