class AddBoolToUsers < ActiveRecord::Migration
  def change
	add_column :users, :use_icon, :boolean
	add_column :users, :avatar, :string
  end
end
