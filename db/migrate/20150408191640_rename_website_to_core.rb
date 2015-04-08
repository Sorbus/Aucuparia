class RenameWebsiteToCore < ActiveRecord::Migration
  def change
    rename_table :websites, :cores
  end
end
