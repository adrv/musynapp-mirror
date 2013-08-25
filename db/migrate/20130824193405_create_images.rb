class CreateImages < ActiveRecord::Migration
  def up
    create_table :images do |t|
      t.integer :imageable_id
      t.string :imageable_type
      t.timestamps
    end
    add_attachment :images, :upload
  end

  def down
    drop_table :images
  end

end
