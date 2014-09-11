class NewsInformation < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller.current_user }
  
  #### paperclip
  if ENV['PAPERCLIP_PATH'] == 1
    has_attached_file :news_image, :styles => { :medium => "220x220>" }
  else
    has_attached_file :news_image, :styles => { :medium => "220x220>" },
    :path => "/home/azureuser/shared/public/system/:class/:attachment/:id/:style/:basename.:extension",
    :url => "/home/azureuser/shared/public/system/:class/:attachment/:id/:style/:basename.:extension"
  end
  validates_attachment_content_type :news_image, :content_type => /\Aimage\/.*\Z/
  ####

  validates :title, uniqueness: {scope: :publish_start}, presence: true 
  validates :publish_start, :publish_end, presence: true 

  scope :recent, -> { order(created_at: :desc).limit(5) }

  # pagination display
  self.per_page = 10
end
