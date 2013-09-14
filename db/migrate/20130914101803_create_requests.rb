class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :requester_id
      t.string :requester_type
      t.integer :requested_id
      t.string :requested_type
      t.string :state, default: 'proposed'

      t.timestamps
    end
  end
end
