class Province < ActiveRecord::Base
  belongs_to :region
  has_many :municipalities
  default_scope order('name asc')
end
