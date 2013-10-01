class Admin < ActiveRecord::Base
  has_one :registration, as: :registrateable
end
