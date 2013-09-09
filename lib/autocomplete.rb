module Autocomplete
  def to_autocomplete query
    self.where('name LIKE ?', "%#{query}%").pluck('name')
  end
end
