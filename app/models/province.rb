class Province < ActiveRecord::Base
  belongs_to :region
  has_many :municipalities

  scope :region_id, -> id { where(region_id: id).order('name ASC') }
end
