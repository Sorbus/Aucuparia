class AddStoreColumnToCore < ActiveRecord::Migration
  def change
	add_column :cores, :links, :text
  end
end
