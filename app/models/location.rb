class Location < ActiveRecord::Base
  has_many :jaunts, through: :jaunt_locations
  has_many :jaunt_locations
end
