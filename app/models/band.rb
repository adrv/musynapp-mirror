class Band < ActiveRecord::Base

  acts_as_messageable
  scoped_search on: :name
  scoped_search in: :genre, on: :title

  include Autocomplete
  
  has_one :registration, as: :registrateable, dependent: :destroy
  has_many :songs, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_many :shows, dependent: :destroy
  has_and_belongs_to_many :fans
  belongs_to :genre
  has_many :requests_received, as: :requested, class_name: 'Request', dependent: :destroy
  has_many :requests_sent, as: :requester, class_name: 'Request', dependent: :destroy

  before_destroy { fans.clear }

  serialize :links

  before_create :prepare_links, if: -> { self.links.present? }

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
