class Region < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  has_many :provinces
  has_many :regional_officers

  def self.values_for_select
    Region.all.map{ |r| [r.to_s, r.id]}
  end

  def to_s
    "#{code} - #{name}"
  end

end
