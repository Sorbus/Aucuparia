class CreateWebsite < ActiveRecord::Migration
  def change
    create_table :websites do |t|
	  t.string :title
	  t.text :content
	  t.string :menu_title

      t.timestamps null: false
    end
  end
end
