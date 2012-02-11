class CreateHorarios < ActiveRecord::Migration
  def change
    create_table :horarios do |t|
      t.integer :cine_id
      t.integer :pelicula_id
      t.string :horarios
    end
  end
end
