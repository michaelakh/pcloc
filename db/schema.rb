# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180122165130) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "offices", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "postcode"
    t.string "street_ad"
    t.string "town_city"
    t.string "phone_no"
    t.string "county"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "lat"
    t.float "lon"
    t.index ["lat"], name: "index_offices_on_lat"
    t.index ["lon"], name: "index_offices_on_lon"
  end

end
