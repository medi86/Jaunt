class Jaunt < ActiveRecord::Base
  has_many :locations
  belongs_to :user

  include Tire::Model::Search
  include Tire::Model::Callbacks
end
