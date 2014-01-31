class Municipality < ActiveRecord::Base
  belongs_to :province
  has_many :barangays
end
