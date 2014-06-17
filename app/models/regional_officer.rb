class RegionalOfficer < ActiveRecord::Base
  belongs_to :region

  validates :name, :ro_type, :designation, :region_id, presence: true
end
