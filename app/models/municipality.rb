class Municipality < ActiveRecord::Base

  has_many :barangays
  has_many :subprojects
  has_many :muni_fund_allocations
  belongs_to :group
  belongs_to :province

  scope :region_id, -> region_id {
    includes(:province).where('provinces.region_id' => region_id) 
  }
  scope :province_id, -> id { where(province_id: id).order(:name) }
  scope :with_id,     -> id { where id: id }

  # scope :region_id, -> id {joins(:province).where('province.region' == id)}

  # if ENV['ERFRS_USES_POSTGRESQL']
  scope :with_year, -> year { where 'EXTRACT(YEAR FROM created_at) = ?', year }
  # else
  #   scope :with_year, -> year { where 'YEAR(created_at) = ?', year  }
  # end
  
end
