class Venue < ActiveRecord::Base
  has_one :authentication, as: :authenticatable
end
