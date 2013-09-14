class Show < ActiveRecord::Base
  belongs_to :venue
  belongs_to :band
  
  scope :completed, lambda { includes(:band, :venue).where('bands.virtual = ? AND venues.virtual = ?', false, false) }
  scope :next, lambda { |count=10| order('dt DESC').limit count }
  scope :by_genre, lambda { |genre| includes(band: :genre).where('genres.title = ?', genre)}

  def to_s
    name
  end

  def info
    "#{dt.strftime("%H:%M")} #{band.name} at #{venue.name}"
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
  
end
