class RenameHorariosByHoras < ActiveRecord::Migration
  def up
     rename_column :horarios, :horarios, :horas
  end

  def down
  end
end
