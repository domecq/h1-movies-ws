class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :model
      t.string :phone
      t.string :query
      t.string :country

      t.timestamps
    end
  end
end
