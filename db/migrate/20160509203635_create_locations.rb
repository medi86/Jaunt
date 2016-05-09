class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.integer :position
      t.integer :jaunt_id

      t.timestamps null: false
    end
  end
end
