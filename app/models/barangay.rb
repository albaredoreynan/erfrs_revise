class Barangay < ActiveRecord::Base
  belongs_to :municipality
  has_many :subprojects
  delegate :province, to: :municipality, :allow_nil => true

  scope :municipality_id, -> id { where(municipality_id: id).order(:name) }
  scope :region_id, -> region_id { includes(municipality: :province).where('provinces.region_id' => region_id) 
  }
  scope :province_id, -> id{joins(:municipality).where('municipalities.province_id' => id)}
  scope :with_id,     -> id { where id: id }

end
