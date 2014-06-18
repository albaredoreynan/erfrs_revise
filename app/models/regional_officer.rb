class RegionalOfficer < ActiveRecord::Base
  belongs_to :region

  validates :name, :ro_type, :designation, :region_id, presence: true

  scope :ro_type,   -> (type) { where(ro_type: type) }
  scope :region_id, -> (id)   { where(region_id: id) }

  BOX = %w{A B}
  ROTYPE= %w{OR DV}
end
