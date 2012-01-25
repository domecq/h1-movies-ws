class AddExternalIdToCines < ActiveRecord::Migration
  def change
    add_column :cines, :external_id, :integer

  end
end
