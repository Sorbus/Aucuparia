class CreateLogolinks < ActiveRecord::Migration
	def change
		create_table :logolinks do |t|
			t.string :url
			t.string :css_id
			t.string :css_class
			t.boolean :display
			t.timestamps null: false
		end
	end
end
