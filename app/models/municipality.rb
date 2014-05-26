class Municipality < ActiveRecord::Base
  belongs_to :province
  has_many :barangays
  has_many :subprojects

  scope :province_id, -> id { where(province_id: id).order(:name) }

  if ENV['ERFRS_USES_POSTGRESQL']
    scope :with_year, -> year { where 'EXTRACT(YEAR FROM created_at) = ?', year }
  else
    scope :with_year, -> year { where 'YEAR(created_at) = ?', year  }
  end

end
