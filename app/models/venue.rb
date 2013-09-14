class Venue < ActiveRecord::Base
  
  class << self
    include Autocomplete
  end

  has_one :registration, as: :registrateable
  has_one :menu
  has_many :videos
  has_many :images, as: :imageable
  has_many :shows
  has_many :requests_received, as: :requested, class_name: 'Request'
  has_many :requests_sent, as: :requester, class_name: 'Request'
  has_and_belongs_to_many :fans
  
  serialize :links

  def to_s
    name
  end

  def virtual?
    registration.nil?
  end

end
