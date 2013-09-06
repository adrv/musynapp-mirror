class Show < ActiveRecord::Base
  belongs_to :venue
  belongs_to :band

  validates_presence_of :band, :venue
end
