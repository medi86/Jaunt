class Jaunt < ActiveRecord::Base
  has_many :locations, through: :jaunt_locations
  has_many :jaunt_locations
end
