class Show < ActiveRecord::Base
  
  has_one :request
  belongs_to :band
  belongs_to :venue
  
  scope :completed, lambda { includes(:band, :venue).where('bands.virtual = ? AND venues.virtual = ?', false, false) }
  scope :next, lambda { |count=10| order('dt DESC').limit count }
  scope :by_genre, lambda { |genre| includes(band: :genre).where('genres.title = ?', genre)}
  
  after_create :send_request

  def to_s
    name
  end

  # Produces output with format:
  # { 'Classical' => [show1, show2, ...], ... }
  def self.genres_map per_genre
    result = {}
    genres = Genre.pluck :title
    genres.each do |genre|
      result[genre] = Show.by_genre(genre).next(per_genre)
    end
    result
  end


  private

  def send_request
    requester, requested = (self.requested_type == 'venue') ? [band, venue] : [venue, band]
    create_request requested: requested, requester: requester
  end
  
end
