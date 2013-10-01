class Fan < ActiveRecord::Base
  has_attached_file :avatar
  has_one :registration, as: :registrateable, dependent: :destroy
  has_many :friendships, class_name: 'FanFriendship', dependent: :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "FanFriendship", :foreign_key => "friend_id", dependent: :destroy
  has_many :inverse_friends, :through => :inverse_friendships, :source => :fan
  has_many :requests_sent, as: :requester, class_name: 'Request', dependent: :destroy
  has_and_belongs_to_many :favorite_venues, class_name: 'Venue'
  has_and_belongs_to_many :favorite_bands, class_name: 'Band'
  has_and_belongs_to_many :shows

  before_destroy { favorite_bands.clear; favorite_venues.clear }


  include Autocomplete

  def friends_ids
    friends.to_json(only: [:id, :name])
  end

  def friends_ids= ids
    friendships.clear
    ids[0].split(',').select(&:present?).map do |friend_id|
      friendships.build friend_id: friend_id
    end
  end

  def favorite_venues_ids
    favorite_venues.to_json(only: [:id, :name])
  end

  def favorite_venues_ids= ids
    favorite_venues.clear
    ids[0].split(',').select(&:present?).map do |venue_id|
      favorite_venues << Venue.find(venue_id)
    end
  end

  def favorite_bands_ids
    favorite_bands.to_json(only: [:id, :name])
  end

  def favorite_bands_ids= ids
    favorite_bands.clear
    ids[0].split(',').select(&:present?).map do |band_id|
      favorite_bands << Band.find(band_id)
    end
  end

  # TODO:
  # def favorites= type, ids

end
