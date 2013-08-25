class Band < ActiveRecord::Base
  has_one :registration, as: :registrateable
  has_many :songs
  has_many :images, as: :imageable
  has_and_belongs_to_many :fans
  belongs_to :genre

  accepts_nested_attributes_for :songs, :images 


  serialize :links

  before_save :prepare_links, if: -> { self.links.present? }

  private

  def prepare_links
    self.links = self.links.split(',').map(&:strip)
  end

end
