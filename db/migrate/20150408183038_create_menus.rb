class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
	  t.string :title
	  t.boolean :visible

      t.timestamps null: false
    end
  end
end
