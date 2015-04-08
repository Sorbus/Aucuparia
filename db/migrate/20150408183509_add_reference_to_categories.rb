class AddReferenceToCategories < ActiveRecord::Migration
  def change
    add_reference :categories, :menu, index: true
    add_foreign_key :categories, :menus
  end
end
