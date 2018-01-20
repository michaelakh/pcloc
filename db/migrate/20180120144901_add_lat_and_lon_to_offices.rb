class AddLatAndLonToOffices < ActiveRecord::Migration[5.0]
  def up
    add_column :offices, :lat, :string
    add_column :offices, :lon, :string
    
    add_index :offices, :lat
    add_index :offices, :lon
  end
  
  def down
    remove_column :offices, :lon
    remove_column :offices, :lat
  end
end
