class CreateFanFriendship < ActiveRecord::Migration
  def change
    create_table :fan_friendships do |t|
      t.integer :fan_id
      t.integer :friend_id
    end
  end
end
