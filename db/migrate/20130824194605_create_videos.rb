class CreateVideos < ActiveRecord::Migration
  def up
    create_table :videos do |t|
      t.integer :venue_id
      t.string :link

      t.timestamps
    end
    add_attachment :videos, :upload
  end

  def down
    drop_table :videos
  end
end
