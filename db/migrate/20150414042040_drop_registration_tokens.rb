class DropRegistrationTokens < ActiveRecord::Migration
  def change
	drop_table :registration_tokens
  end
end
