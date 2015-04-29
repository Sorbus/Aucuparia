class AddDefaultToItem < ActiveRecord::Migration
  def change
	change_column :items, :published, :boolean, :default => false
  end
end
