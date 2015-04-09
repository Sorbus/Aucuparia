class RenameCoreToStaticPages < ActiveRecord::Migration
  def change
    rename_table :cores, :static_pages
  end
end
