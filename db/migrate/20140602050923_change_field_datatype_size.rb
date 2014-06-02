class ChangeFieldDatatypeSize < ActiveRecord::Migration
  def change
  	remove_column :news_informations, :content
  	add_column :news_informations, :content, :text, :limit => 42949672
  end
end
