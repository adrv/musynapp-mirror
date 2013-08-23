class CreateFansBands < ActiveRecord::Migration
  def change
    create_table :bands_fans do |t|
      t.references :fan, :null => false
      t.references :band, :null => false
    end
  end
end
