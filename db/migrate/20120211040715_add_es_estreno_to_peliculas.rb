class AddEsEstrenoToPeliculas < ActiveRecord::Migration
  def change
    add_column :peliculas, :es_estreno, :bool

  end
end
