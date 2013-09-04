class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.integer :venue_id
      t.timestamps
    end
    add_attachment :menus, :upload
  end
end
