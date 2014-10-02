class Group < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  has_many :municipalities
  has_many :subprojects
  belongs_to :fund_source
end

