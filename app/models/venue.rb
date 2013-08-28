class Venue < ActiveRecord::Base
  has_one :registration, as: :registrateable
  has_many :videos
  has_many :images, as: :imageable
  has_and_belongs_to_many :fans
  has_attached_file :menu
  
  accepts_nested_attributes_for :videos, :images

  serialize :links
end
