class AddLatitudeToCines < ActiveRecord::Migration
  def change
    add_column :cines, :latitude, :float
    add_column :cines, :longitude, :float
    remove_column :cines, :lat
    remove_column :cines, :long

  end
end
