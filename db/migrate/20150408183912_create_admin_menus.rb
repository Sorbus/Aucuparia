class CreateAdminMenus < ActiveRecord::Migration
  def change
    create_table :admin_menus do |t|

      t.timestamps null: false
    end
  end
end
