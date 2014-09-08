class AddAttachmentNewsImageToNewsInformations < ActiveRecord::Migration
  def self.up
    change_table :news_informations do |t|
      t.attachment :news_image
    end
  end

  def self.down
    remove_attachment :news_informations, :news_image
  end
end
