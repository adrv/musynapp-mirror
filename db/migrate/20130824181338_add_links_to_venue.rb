class AddLinksToVenue < ActiveRecord::Migration
  def change
    add_column :venues, :links, :text
  end
end
