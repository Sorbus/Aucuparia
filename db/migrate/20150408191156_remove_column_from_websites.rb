class RemoveColumnFromWebsites < ActiveRecord::Migration
  def change
    remove_column :websites, :menu_title
  end
end
