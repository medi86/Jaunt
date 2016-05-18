class ChangeToJaunts < ActiveRecord::Migration
  def change
    remove_column :locations, :jaunt_id
    create_table :jaunt_locations do |t|
      t.integer :jaunt_id
      t.integer :location_id
    end
  end
end
