class Venue < ActiveRecord::Base

  acts_as_messageable
  scoped_search :on => [:name, :address]
  
  include Autocomplete

  has_one :registration, as: :registrateable
  has_one :menu
  has_many :videos
  has_many :images, as: :imageable
  has_many :shows
  has_many :requests_received, as: :requested, class_name: 'Request'
  has_many :requests_sent, as: :requester, class_name: 'Request'
  has_and_belongs_to_many :fans
  
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
