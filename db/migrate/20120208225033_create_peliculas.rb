class CreatePeliculas < ActiveRecord::Migration
  def change
    create_table :peliculas do |t|
      t.string :titulo
      t.string :imagen
      t.text :descripcion
      t.string :titulo_original
      t.string :pais
      t.integer :anio
      t.string :duracion
      t.string :calificacion
      t.date :estreno
      t.string :web
      t.string :genero
      t.string :interpretes
      t.string :director
      t.string :guionista
      t.string :fotografia
      t.string :musica

      t.timestamps
    end
  end
end
