class Band < ActiveRecord::Base
  has_one :registration, as: :registrateable
end
