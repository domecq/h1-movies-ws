class CreateCinePeliculaJoinTable < ActiveRecord::Migration
  def up
    create_table :cines_peliculas, :id => false do |t|
      t.integer :cine_id
      t.integer :pelicula_id
    end
    
  end

  def down
    drop_table:cines_peliculas
    
  end
end
