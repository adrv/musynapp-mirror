class AddCurrentStepToRegistrations < ActiveRecord::Migration
  def change
    add_column :registrations, :current_step, :string
  end
end
