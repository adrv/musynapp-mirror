class Genre < ActiveRecord::Base
  has_many :bands

  validates_uniqueness_of :title

  def to_s
    title
  end

end
