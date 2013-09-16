class AddApprovedColumnToShows < ActiveRecord::Migration
  def change
    add_column :shows, :approved, :boolean
  end
end
