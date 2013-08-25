class AddLinksToBand < ActiveRecord::Migration
  def change
    add_column :bands, :links, :text
  end
end
