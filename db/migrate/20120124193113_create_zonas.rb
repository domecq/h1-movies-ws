class CreateZonas < ActiveRecord::Migration
  def change
    create_table :zonas do |t|
      t.string :nombre
      t.decimal :lat
      t.decimal :long

      t.timestamps
    end
  end
end
