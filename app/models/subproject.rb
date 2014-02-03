class Subproject < ActiveRecord::Base
  belongs_to :region
  belongs_to :province
  belongs_to :municipality
  belongs_to :barangay

  belongs_to :user
  
  has_many :team_members
  accepts_nested_attributes_for :team_members, reject_if: :reject_team_members

  STATUSES = %w{Draft Published}
  CATEGORIES = %w{Category1 Category2}
  PHYSICAL_TARGETS = %w{Target1 Target2}
  COST_PARAMETERS = %w{Parameter1 Parameter2}
  MODES_OF_IMPLEMENTATION = %w{Mode1 Mode2}

  ####################### SCOPES ###########################

  scope :with_user,   -> username { fetch_all_created_by username }
  scope :with_id,     -> id { where id: id }
  scope :with_status, -> status { where status: status }

  if ENV['ERFRS_USES_POSTGRESQL']
    scope :with_year, -> year { where 'EXTRACT(YEAR FROM created_at) = ?', year }
  else
    scope :with_year, -> year { where 'YEAR(created_at) = ?', year  }
  end

  %w{region province municipality barangay}.each do |place|
    scope "subproject_#{place}_id".intern, -> place_id { where "#{place}_id" => place_id }
  end

  ####################### SCOPES ###########################
  
  %i[first second third].each do |nth| 
    method_name = "#{nth}_tranch_date_required"
    define_method(method_name) do
      value = read_attribute(method_name)
      value ? value.to_s(:long)[0..-7] : value
    end
  end

  private

  def self.fetch_all_created_by(username)
    users = User.where 'username like ?', "%#{username}%"
    users.any? ? where( user_id: users.pluck(:id) ) : none
  end

  def reject_team_members(attributed)
    attributed['name'].blank?
  end
end
