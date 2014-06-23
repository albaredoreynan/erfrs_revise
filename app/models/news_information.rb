class NewsInformation < ActiveRecord::Base
  validates :title, uniqueness: {scope: :publish_start}
end
