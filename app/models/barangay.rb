class Barangay < ActiveRecord::Base
  belongs_to :municipality
  
  default_scope order('name asc')
end
