class AddAddressToCines < ActiveRecord::Migration
  def change
    add_column :cines, :address, :string

  end
end
