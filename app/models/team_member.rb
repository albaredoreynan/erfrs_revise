class TeamMember < ActiveRecord::Base
  belongs_to :subproject
  belongs_to :designation

  default_scope -> { order('name ASC') }

  # can meta prog this later
  def self.regional
    d_ids = Designation.where(designation_type: 'regional')
    where(designation_id: d_ids)
  end

  def self.municipal
    d_ids = Designation.where(designation_type: 'municipal')
    where(designation_id: d_ids)
  end

  def self.barangay
    d_ids = Designation.where(designation_type: 'barangay')
    where(designation_id: d_ids)
  end
end
