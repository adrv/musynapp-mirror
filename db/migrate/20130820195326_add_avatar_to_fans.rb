class AddAvatarToFans < ActiveRecord::Migration
  def self.up
    add_attachment :fans, :avatar
  end

  def self.down
    remove_attachment :fans, :avatar
  end
end
