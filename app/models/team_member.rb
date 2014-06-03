class TeamMember < ActiveRecord::Base
  belongs_to :subproject
  belongs_to :designation
end
