class RemoveLonlatFromOffices < ActiveRecord::Migration[5.1]
  def change
    remove_column :offices, :lonlat
  end
end
