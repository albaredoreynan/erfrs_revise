class NewsInformation < ActiveRecord::Base
  validates :title, uniqueness: {scope: :publish_start}, presence: true 
  validates :publish_start, :publish_end, presence: true 
end
