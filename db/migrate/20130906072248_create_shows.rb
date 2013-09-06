class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.integer :venue_id
      t.integer :band_id
      t.datetime :dt
      t.integer :crowd_size
      t.text :address
      t.decimal :cost, :precision => 8, :scale => 2
      t.text :description
      t.boolean :private

      t.timestamps
    end
  end
end
