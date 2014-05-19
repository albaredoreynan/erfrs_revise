class Barangay < ActiveRecord::Base
  belongs_to :municipality
  has_many :subprojects
  
  scope :municipality_id, -> id { where(municipality_id: id).order(:name) }
end
