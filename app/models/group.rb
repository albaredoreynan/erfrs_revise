class Group < ActiveRecord::Base
  has_many :municipalities
  has_many :subprojects
  belongs_to :fund_source
end

