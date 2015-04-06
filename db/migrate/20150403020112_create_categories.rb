class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :summary
	  t.references :website, index: true

      t.timestamps null: false
    end
	add_foreign_key :categories, :websites
  end
end
