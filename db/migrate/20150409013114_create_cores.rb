class CreateCores < ActiveRecord::Migration
  def change
    create_table :cores do |t|
      t.text :twitter
	  t.text :github
	  t.text :email
	  t.boolean :show_icons
	  t.boolean :show_login
      t.timestamps null: false
    end
  end
end
