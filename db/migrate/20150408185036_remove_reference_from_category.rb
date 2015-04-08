class RemoveReferenceFromCategory < ActiveRecord::Migration
  def change
	remove_reference :categories, :website
  end
end
