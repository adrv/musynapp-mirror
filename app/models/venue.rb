class Venue < ActiveRecord::Base

  acts_as_messageable
  scoped_search :on => [:name, :address]
  
  include Autocomplete

  has_one :registration, as: :registrateable, dependent: :destroy
  has_one :menu
  has_many :videos, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_many :shows, dependent: :destroy
  has_many :requests_received, as: :requested, class_name: 'Request', dependent: :destroy
  has_many :requests_sent, as: :requester, class_name: 'Request', dependent: :destroy
  has_and_belongs_to_many :fans

  before_destroy { fans.clear }

  serialize :links

  def virtual?
    registration.nil?
  end
  
  # Required for Mailboxer gem to work
  def mailboxer_email(obj)
    nil
  end

  def to_s
    name
  end

end
