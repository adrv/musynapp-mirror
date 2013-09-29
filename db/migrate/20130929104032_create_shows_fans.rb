class CreateShowsFans < ActiveRecord::Migration
  def change
    create_table :fans_shows do |t|
      t.references :show, :null => false
      t.references :fan, :null => false
    end
  end
end
