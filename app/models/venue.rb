class Venue < ActiveRecord::Base
  has_one :registration, as: :registrateable
  has_many :videos
  has_many :images, as: :imageable
  has_and_belongs_to_many :fans
  has_attached_file :menu
  
  accepts_nested_attributes_for  :images, reject_if: :validate_images_count
  accepts_nested_attributes_for  :videos, reject_if: :validate_videos_count

  def validate_videos_count
    if videos.length >= 3
      errors.add(:videos, 'Only 3 videos allowed') 
      raise 'Unable to create a video'
    end
  end

  def validate_images_count
    if images.length >= 3
      errors.add(:images, 'Only 3 images allowed')
      raise 'Unable to create an image'
    end
  end

  serialize :links
end
