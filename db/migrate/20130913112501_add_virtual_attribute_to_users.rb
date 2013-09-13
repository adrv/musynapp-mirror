class AddVirtualAttributeToUsers < ActiveRecord::Migration
  def change
    add_column :venues, :virtual, :boolean, default: false
    add_column :bands, :virtual, :boolean, default: false
  end
end
