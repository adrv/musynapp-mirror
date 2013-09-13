class AddPrimaryToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :primary_song, :boolean
  end
end
