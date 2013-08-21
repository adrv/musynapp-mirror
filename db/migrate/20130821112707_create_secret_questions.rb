class CreateSecretQuestions < ActiveRecord::Migration
  def change
    create_table :secret_questions do |t|
      t.string :body

      t.timestamps
    end
  end
end
