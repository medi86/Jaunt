class CreateJaunts < ActiveRecord::Migration
  def change
    create_table :jaunts do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
