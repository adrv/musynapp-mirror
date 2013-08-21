class Registration < ActiveRecord::Base
  belongs_to :registrateable, polymorphic: true
  has_many :secret_question_answers

  accepts_nested_attributes_for :secret_question_answers

  validates_presence_of :registrateable
  validates_uniqueness_of :username

  has_secure_password
end
