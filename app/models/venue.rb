class Venue < ActiveRecord::Base

  class << self
    include Autocomplete
  end

  has_one :registration, as: :registrateable
  has_one :menu
  has_many :videos
  has_many :images, as: :imageable
  has_many :shows
  has_and_belongs_to_many :fans
  
  serialize :links
end
