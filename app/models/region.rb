class Region < ActiveRecord::Base
  has_many :provinces

  def self.values_for_select
    Region.all.map{ |r| [r.to_s, r.id]}
  end

  def to_s
    "#{code} - #{name}"
  end
end