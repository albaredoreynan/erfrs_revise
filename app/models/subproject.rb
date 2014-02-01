class Subproject < ActiveRecord::Base
  belongs_to :region
  belongs_to :province
  belongs_to :municipality
  belongs_to :barangay

  STATUSES = %w{Draft Published}
  CATEGORIES = %w{Category1 Category2}
  PHYSICAL_TARGETS = %w{Target1 Target2}
  COST_PARAMETERS = %w{Parameter1 Parameter2}
  MODES_OF_IMPLEMENTATION = %w{Mode1 Mode2}

  ####################### SCOPES ###########################

  scope :by_user,     -> username { fetch_all_created_by username }
  scope :with_id,     -> id { where id: id }
  scope :with_status, -> status { where status: status }

  if ENV['ERFRS_USES_POSTGRESQL']
    scope :with_year, -> year { where 'EXTRACT(YEAR FROM created_at) = ?', year }
  else
    scope :with_year, -> year { where 'YEAR(created_at) = ?', year  }
  end

  %w{region province municipality barangay}.each do |place|
    scope "from_#{place}".intern, -> place_id { where "#{place}_id" => place_id }
  end

  ####################### SCOPES ###########################

  private

  def self.fetch_all_created_by(username)
    users = User.where 'username like ?', "%#{username}%"
    user.any? ? where( user_id: users.pluck(:id) ) : none
  end
end
