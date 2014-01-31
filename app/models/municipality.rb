class Municipality < ActiveRecord::Base
  belongs_to :province
  has_many :barangays
  default_scope order('name asc')
end
