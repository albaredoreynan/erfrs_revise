class TeamMember < ActiveRecord::Base
  belongs_to :subproject
  belongs_to :designation

  default_scope -> { order('name ASC') }
end
