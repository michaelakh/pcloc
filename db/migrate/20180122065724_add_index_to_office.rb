class AddIndexToOffice < ActiveRecord::Migration[5.1]
  def change
    add_index :offices, :lonlat
  end
end
