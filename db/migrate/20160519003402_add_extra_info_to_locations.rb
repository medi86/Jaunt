class AddExtraInfoToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :phone_number, :string
    add_column :locations, :website, :string
    add_column :locations, :hours, :string
  end
end
