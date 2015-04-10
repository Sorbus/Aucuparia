class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_reference :comments, :item, index: true
    add_foreign_key :comments, :items
	add_reference :comments, :user, index: true
	add_foreign_key :comments, :users
	
	add_column :comments, :body, :text
	add_column :comments, :ancestry, :string
	
	add_index :comments, :ancestry
  end
end
