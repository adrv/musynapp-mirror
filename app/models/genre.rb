class Genre < ActiveRecord::Base
  has_many :bands

  def to_s
    title
  end

end
