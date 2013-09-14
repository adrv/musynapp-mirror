class AddShowIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :show_id, :integer
  end
end
