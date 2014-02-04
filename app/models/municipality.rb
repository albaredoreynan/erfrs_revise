class Municipality < ActiveRecord::Base
  belongs_to :province
  has_many :barangays

  scope :province_id, -> id { where(province_id: id).order(:name) }
end
