class Designation < ActiveRecord::Base
  default_scope -> { order('name ASC') }

  TYPE = %w(barangay municipal regional)
end
