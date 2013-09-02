class Band < ActiveRecord::Base
  has_one :registration, as: :registrateable
  has_many :songs
  has_many :images, as: :imageable
  has_and_belongs_to_many :fans
  belongs_to :genre
  
  accepts_nested_attributes_for  :images, reject_if: :validate_images_count
  accepts_nested_attributes_for  :songs,  reject_if: :validate_songs_count

  serialize :links

  before_create :prepare_links, if: -> { self.links.present? }

  private

  def prepare_links
    self.links = self.links.split(',').map(&:strip)
  end


  def validate_songs_count
    if songs.length >= 3
      errors.add(:songs, 'Only 3 allowed') 
      raise 'Unable to create a song'
    end
  end

  def validate_images_count
    if images.length >= 3
      errors.add(:images, 'Only 3 allowed')
      raise 'Unable to create an image'
    end
  end

end
