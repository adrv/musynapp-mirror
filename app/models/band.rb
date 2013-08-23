class Band < ActiveRecord::Base
  has_one :registration, as: :registrateable
  has_and_belongs_to_many :fans
end
