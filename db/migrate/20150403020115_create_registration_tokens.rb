class CreateRegistrationTokens < ActiveRecord::Migration
  def change
    create_table :registration_tokens do |t|
	  t.string :token
	  t.references :user

      t.timestamps null: false
    end
	add_foreign_key :registration_tokens, :users
  end
end
