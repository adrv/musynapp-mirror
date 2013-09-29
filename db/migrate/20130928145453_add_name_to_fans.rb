class AddNameToFans < ActiveRecord::Migration
  def change
    add_column :fans, :name, :string
  end
end
