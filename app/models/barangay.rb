class Barangay < ActiveRecord::Base
  belongs_to :municipality
  
  scope :municipality_id, -> id { where(municipality_id: id).order(:name) }
end
