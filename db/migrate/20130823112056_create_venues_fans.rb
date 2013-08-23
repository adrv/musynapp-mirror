class CreateVenuesFans < ActiveRecord::Migration
  def change
    create_table :fans_venues do |t|
      t.references :fan, :null => false
      t.references :venue, :null => false
    end
  end
end
