class DropTableGroupMemberships < ActiveRecord::Migration
  def change
    drop_table :group_memberships
  end
end
