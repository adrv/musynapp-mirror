module Autocomplete

  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    def to_autocomplete query
      self.where('name LIKE ?', "%#{query}%")
    end
  end

end
