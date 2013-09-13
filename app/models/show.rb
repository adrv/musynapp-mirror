class Show < ActiveRecord::Base
  belongs_to :venue
  belongs_to :band
  
  def to_s
    name
  end
  
end
