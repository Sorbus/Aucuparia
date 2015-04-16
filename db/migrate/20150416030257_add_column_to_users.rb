class AddColumnToUsers < ActiveRecord::Migration
  def change
	add_column :users, :icon, :integer
  end
end
