class AddLocalidadToCines < ActiveRecord::Migration
  def change
    add_column :cines, :localidad, :string

  end
end
