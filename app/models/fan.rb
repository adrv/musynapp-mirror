class Fan < ActiveRecord::Base
  has_one :authentication, as: :authenticatable
end
