class NewsInformation < ActiveRecord::Base
  #### paperclip
  has_attached_file :news_image, :styles => { :medium => "220x220>" }
  validates_attachment_content_type :news_image, :content_type => /\Aimage\/.*\Z/
  ####

  validates :title, uniqueness: {scope: :publish_start}, presence: true 
  validates :publish_start, :publish_end, presence: true 

  scope :recent, -> { order(created_at: :desc).limit(5) }

  # pagination display
  self.per_page = 10
end
