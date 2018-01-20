class CreateOffices < ActiveRecord::Migration[5.0]
  def change
    create_table :offices do |t|
      t.string :name
      t.string :country
      t.string :postcode
      t.string :street_ad
      t.string :town_city
      t.string :phone_no
      t.string :county

      t.timestamps
    end
  end
end
