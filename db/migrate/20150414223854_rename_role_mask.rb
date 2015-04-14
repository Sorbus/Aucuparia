class RenameRoleMask < ActiveRecord::Migration
  def change
	rename_column :users, :role_mask, :roles_mask
  end
end
