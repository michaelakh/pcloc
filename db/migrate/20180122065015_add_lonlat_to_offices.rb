class AddLonlatToOffices < ActiveRecord::Migration[5.1]
  def change
    add_column :offices, :lonlat, :geometry, :srid => 4326
  end
end
