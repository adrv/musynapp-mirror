class CreateSecretQuestionAnswers < ActiveRecord::Migration
  def change
    create_table :secret_question_answers do |t|
      t.string :body
      t.integer :secret_question_id
      t.integer :registration_id

      t.timestamps
    end
  end
end
