module Searchable

  def self.search query
    results = query.is_a?(Hash) ? complex_search(query) : simple_search(query)
    deduplicate results
  end

  # Searches by: venue name, venue address, band name, genre
  # Produces results like:
  # { shows: [show1,show2,...], bands: [band1, band2], venues: [venue1,venue2] }
  def self.simple_search query
    res = {}
    shows = []
    [Venue, Band].each do |clazz|
      type = clazz.to_s.downcase.pluralize
      objects = clazz.search_for(query).includes(:shows)
      res[type] = objects
      shows.concat objects.map{|v| v.shows }.flatten
    end
    res[:shows] = shows.uniq
    res
  end
  
  # query = { venue_name: 'Abc', band_name: 'Qwe', genre: 'Rock', address: 'St. Petersburg' }
  def self.complex_search query
    res = {}
    res['venues'] = []
    res['bands'] = []
    shows = Show.includes(:venue, band: :genre)
         .where('venues.name LIKE ?', "%#{query[:venue_name]}%")
          .where('genres.title LIKE ? ', "%#{query[:genre]}%")
           .where('bands.name LIKE ? ', "%#{query[:band_name]}%")
            .where('venues.address LIKE ? ', "%#{query[:address]}%")
    shows.each do |s|
      res['venues'] << s.venue
      res['bands'] << s.band
    end
    res[:shows] = shows
    res
  end

  def self.deduplicate results
    results.each { |relation, obj_list| results[relation] = obj_list.uniq }
  end

end
