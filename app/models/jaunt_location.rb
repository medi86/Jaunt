class JauntLocation < ActiveRecord::Base
   belongs_to :jaunt
   belongs_to :location
end
