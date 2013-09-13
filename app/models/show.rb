class Show < ActiveRecord::Base
  belongs_to :venue
  belongs_to :band
  
  scope :completed, -> { includes(:band, :venue).where('bands.virtual = ? AND venues.virtual = ?', false, false) }

  def to_s
    name
  end
  
  def self.next count
    completed.order('dt DESC').limit count
  end
  
end
