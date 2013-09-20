class Band < ActiveRecord::Base

  acts_as_messageable

  class << self
    include Autocomplete
  end
  
  has_one :registration, as: :registrateable
  has_many :songs
  has_many :images, as: :imageable
  has_many :shows
  has_and_belongs_to_many :fans
  belongs_to :genre
  has_many :requests_received, as: :requested, class_name: 'Request'
  has_many :requests_sent, as: :requester, class_name: 'Request'
  
  serialize :links

  before_create :prepare_links, if: -> { self.links.present? }

  def primary_song
    songs.where('songs.primary_song = ?', true)[0]
  end

  def virtual?
    registration.nil?
  end

  def to_s
    name
  end

  # Required for Mailboxer gem to work
  def mailboxer_email(obj)
    nil
  end

  private

  def prepare_links
    self.links = self.links.split(',').map(&:strip)
  end

end
