class AddBriefToPeliculas < ActiveRecord::Migration
  def change
    add_column :peliculas, :brief, :string

  end
end
