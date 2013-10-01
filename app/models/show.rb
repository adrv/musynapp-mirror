class Show < ActiveRecord::Base
  
  has_one :request, dependent: :destroy
  delegate :requester, :requested, :approved?, to: :request
  has_many :address_requests, class_name: 'Request', foreign_key: 'show_address_id', dependent: :destroy
  belongs_to :band
  belongs_to :venue
  has_and_belongs_to_many :fans
  
  scope :completed, lambda { includes(:band, :venue).where('bands.virtual = ? AND venues.virtual = ?', false, false).references(:bands, :venues) }
  scope :by_genre, lambda { |genre| includes(band: :genre).where('genres.title = ?', genre).references(:genres) }

  before_destroy { fans.clear }
  after_create :send_request

  def address_exposed_for? user
    return if user.nil?
    return true if user.registrateable_type != 'Fan'
    address_requests.
     with_state('accepted').
      where('requester_id = ? AND requester_type = ?', user.registrateable.id, user.registrateable.class.to_s).
       present?
  end

  def name
    "#{band.name} at #{venue.name}"
  end

  def humanized_time
    dt.strftime("%H:%M %p")
  end

  # Produces output with format:
  # { 'Classical' => [show1, show2, ...], ... }
  def self.genres_map per_genre
    result = {}
    genres = Genre.pluck :title
    genres.each do |genre|
      result[genre] = self.by_genre(genre).upcoming(per_genre)
    end
    result.sort_by{|genre, shows| shows.count }.reverse
  end

  def self.upcoming count=10
    where('dt > ?', DateTime.now).order('dt DESC').limit count
  end    

  def self.upcoming_for user
    type = "#{user.class.to_s.downcase}_id".to_sym
    params = {}
    params[type] = user.id
    self.where(params).upcoming(10)
  end

  def send_address_request_for fan
    address_requests.create requested: band, requester: fan
  end

  def little_people?
    crowd_size? && (fans.count.to_f / crowd_size) < 0.15
  end

  
  private

  def send_request
    requester, requested = (self.requested_type == 'venue') ? [band, venue] : [venue, band]
    create_request requested: requested, requester: requester
  end
  
end
