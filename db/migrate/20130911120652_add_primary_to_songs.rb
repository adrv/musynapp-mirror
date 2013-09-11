class AddPrimaryToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :primary, :boolean
  end
end
