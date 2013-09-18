class Fan < ActiveRecord::Base
  has_attached_file :avatar
  has_one :registration, as: :registrateable
  has_many :friendships, class_name: 'FanFriendship'
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "FanFriendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :fan
  has_many :requests_sent, as: :requester, class_name: 'Request'
  has_and_belongs_to_many :favorite_venues, class_name: 'Venue'
  has_and_belongs_to_many :favorite_bands, class_name: 'Band'
end
