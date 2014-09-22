class MuniFundAllocation < ActiveRecord::Base
  include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller.current_user }
  
	belongs_to :municipality

  # validates :name, :ro_type, :designation, :region_id, presence: true

  scope :municipality_id, -> id { where(municipality_id: id).order(:id) }
  scope :region_id, -> region_id { includes(municipality: :province).where('provinces.region_id' => region_id) 
  }
  scope :province_id, -> id{joins(:municipality).where('municipalities.province_id' => id)}
end
