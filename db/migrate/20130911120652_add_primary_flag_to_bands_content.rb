class AddPrimaryFlagToBandsContent < ActiveRecord::Migration
  def change
    add_column :songs, :primary_flag, :boolean
    add_column :images, :primary_flag, :boolean
  end
end
