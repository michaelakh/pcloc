class ChangeColumnTypeOfOffices < ActiveRecord::Migration[5.0]
  def up
    remove_column :offices, :lat
    remove_column :offices, :lon
    add_column :offices, :lat, :float
    add_column :offices, :lon, :float
  end
  
  def down
    remove_column :offices, :lon
    remove_column :offices, :lat
    add_column :offices, :lon, :string
    add_column :offices, :lat, :string
  end
end
