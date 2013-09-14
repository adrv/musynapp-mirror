class AddRequestedTypeToShows < ActiveRecord::Migration
  def change
    add_column :shows, :requested_type, :string
  end
end
