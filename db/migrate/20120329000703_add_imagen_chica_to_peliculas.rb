class AddImagenChicaToPeliculas < ActiveRecord::Migration
  def change
    add_column :peliculas, :imagen_chica, :string

  end
end
