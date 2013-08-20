class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :username
      t.string :password
      t.string :password_digest
      t.datetime :dob
      t.integer :questionnaire_id
      t.integer :authenticatable_id
      t.string :authenticatable_type

      t.timestamps
    end
  end
end
