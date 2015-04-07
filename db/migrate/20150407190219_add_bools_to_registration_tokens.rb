class AddBoolsToRegistrationTokens < ActiveRecord::Migration
  def change
    add_column :registration_tokens, :can_comment, :boolean
	add_column :registration_tokens, :can_author, :boolean
	add_column :registration_tokens, :is_moderator, :boolean
	add_column :registration_tokens, :is_editor, :boolean
	add_column :registration_tokens, :is_administrator, :boolean
	add_column :registration_tokens, :is_superuser, :boolean
  end
end
