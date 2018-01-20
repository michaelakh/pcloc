class AddIndexToOffices < ActiveRecord::Migration[5.0]
  def up
    add_index :offices, :lat
    add_index :offices, :lon
  end
  
  def down
    remove_index :offices, :lon
    remove_index :offices, :lat
  end
end
