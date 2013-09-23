module Searchable
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
      shows << objects.map{|v| v.shows }.flatten
    end
    res[:shows] = shows.uniq
    res
  end
end
