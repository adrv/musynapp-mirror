class Show < ActiveRecord::Base
  belongs_to :venue
  belongs_to :band
  
  # class << self
  #   %w(venue band).each do |entity|  
  #     define_method("#{entity}=") do |instance|
  #        if instance.is_a? String
  #          if entity_id = 
  #        else
  #          super(instance)
  #        end
  #     end
  #   end
  # end

  def venue= venue
    if venue.is_a? String
      if v_id = Venue.find_by_name(venue).try(:id)
        self.venue_id = v_id
        self.venue_name = nil
      else
        self.venue_id = nil
        self.venue_name = venue
      end
    end
  end

  def band= band
    if band.is_a? String
      if b_id = Band.find_by_name(band).try(:id)
        self.band_id = b_id
        self.band_name = nil
      else
        self.band_id = nil
        self.band_name = band
      end
    end
  end

end
