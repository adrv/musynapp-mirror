class AddMenuToVenue < ActiveRecord::Migration
  def self.up
    add_attachment :venues, :menu
  end

  def self.down
    remove_attachment :venues, :menu
  end
end
