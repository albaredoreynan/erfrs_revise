class Province < ActiveRecord::Base
  include PublicActivity::Model
  # tracked owner: ->(controller, model) { controller.current_user }
  
  belongs_to :region
  has_many :municipalities

  scope :region_id, -> id { where(region_id: id).order('name ASC') }
end
