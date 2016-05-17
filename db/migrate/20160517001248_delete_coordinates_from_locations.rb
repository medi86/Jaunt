class DeleteCoordinatesFromLocations < ActiveRecord::Migration
  def change
    remove_column :locations, :latitude
    remove_column :locations, :longitude
  end
end
