class AddKeyToRegistrationTokens < ActiveRecord::Migration
  def change
    add_column :registration_tokens, :access_tier, :integer
    add_column :registration_tokens, :used, :boolean
	add_column :registration_tokens, :user, :reference, index: true
  end
  add_foreign_key :registration_tokens, :users
end
