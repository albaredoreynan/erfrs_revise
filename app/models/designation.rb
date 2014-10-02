class Designation < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  default_scope -> { order('name ASC') }

  TYPE = %w(barangay municipal regional)
end
