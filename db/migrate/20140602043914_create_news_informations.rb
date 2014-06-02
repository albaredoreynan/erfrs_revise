class CreateNewsInformations < ActiveRecord::Migration
  def change
    create_table :news_informations do |t|
    	t.string :title
    	t.text :content
    	t.datetime :publish_start
    	t.datetime :publish_end
      t.timestamps
    end
  end
end
