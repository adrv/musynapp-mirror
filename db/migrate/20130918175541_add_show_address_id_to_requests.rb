class AddShowAddressIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :show_address_id, :integer
  end
end
