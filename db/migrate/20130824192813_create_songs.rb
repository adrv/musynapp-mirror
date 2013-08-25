class CreateSongs < ActiveRecord::Migration
  def up
    create_table :songs do |t|
      t.integer :band_id
      t.timestamps
    end
    add_attachment :songs, :upload
  end

  def down
    drop_table :songs
  end
end
