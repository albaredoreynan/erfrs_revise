class NewsInformation < ActiveRecord::Base
  validates :title, uniqueness: {scope: :publish_start}, presence: true 
  validates :publish_start, :publish_end, presence: true 

  scope :recent, -> { order(created_at: :desc).limit(5) }

  # pagination display
  self.per_page = 10
end
