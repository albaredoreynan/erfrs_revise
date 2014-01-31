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
end
