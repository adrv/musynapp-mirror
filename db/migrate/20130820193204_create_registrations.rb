class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :username
      t.string :password
      t.string :password_digest
      t.datetime :dob
      t.integer :questionnaire_id
      t.integer :registrateable_id
      t.string :registrateable_type

      t.timestamps
    end
  end
end
