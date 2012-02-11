class AddExternalIdToPeliculas < ActiveRecord::Migration
  def change
    add_column :peliculas, :external_id, :integer

  end
end
