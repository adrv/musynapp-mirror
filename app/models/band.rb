class Band < ActiveRecord::Base

  class << self
    include Autocomplete
  end
  
  has_one :registration, as: :registrateable
  has_many :songs
  has_many :images, as: :imageable
  has_many :shows
  has_and_belongs_to_many :fans
  belongs_to :genre
  
  serialize :links

  before_create :prepare_links, if: -> { self.links.present? }

  private

  def prepare_links
    self.links = self.links.split(',').map(&:strip)
  end

end
