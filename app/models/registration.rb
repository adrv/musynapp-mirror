class Registration < ActiveRecord::Base
  belongs_to :registrateable, polymorphic: true
  has_many :secret_question_answers

  accepts_nested_attributes_for :secret_question_answers

  validates_presence_of :registrateable
  validates_uniqueness_of :username

  has_secure_password

  REGISTRATION_STEPS = { Fan:   {},
                         Band:  { edit: 'edit_media' },
                         Venue: { edit: 'edit_media', edit_media: 'edit_schedule' }
                       }

  before_create :set_initial_step

  def advance_registration
    self.current_step = next_step
    self.save
    self.current_step
  end

  def pending?
    current_step.present?
  end

  def next_step
    REGISTRATION_STEPS[registrateable_type.to_sym][current_step.to_sym]
  end


  private

  def set_initial_step
    self.current_step ||= 'edit'
  end

end
