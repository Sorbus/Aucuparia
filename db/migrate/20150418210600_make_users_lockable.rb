class MakeUsersLockable < ActiveRecord::Migration
  def change
    change_column :users, :failed_attempts, :integer, default: 0
  end
end
