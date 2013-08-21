class SecretQuestionAnswer < ActiveRecord::Base
  belongs_to :registration
  belongs_to :secret_question
end
