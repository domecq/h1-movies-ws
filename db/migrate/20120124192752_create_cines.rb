class CreateCines < ActiveRecord::Migration
  def change
    create_table :cines do |t|
      t.string :nombre
      t.string :direccion
      t.string :query
      t.string :country
      t.string :tel
      t.decimal :lat
      t.decimal :long
      t.integer :zona_id

      t.timestamps
    end
  end
end
