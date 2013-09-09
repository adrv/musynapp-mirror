class AddVenueNameToShows < ActiveRecord::Migration
  def change
    add_column :shows, :venue_name, :string
    add_column :shows, :band_name, :string
  end
end
