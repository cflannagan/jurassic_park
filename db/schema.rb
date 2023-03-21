# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_03_21_145856) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "dinosaur_classification", ["carnivore", "herbivore"]
  create_enum "power_classification", ["ACTIVE", "DOWN"]

  create_table "cages", force: :cascade do |t|
    t.integer "capacity", default: 1, null: false
    t.enum "power_status", default: "DOWN", null: false, enum_type: "power_classification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dinosaurs", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "species_id", null: false
    t.bigint "cage_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cage_id"], name: "index_dinosaurs_on_cage_id"
    t.index ["name"], name: "index_dinosaurs_on_name", unique: true
    t.index ["species_id"], name: "index_dinosaurs_on_species_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name", null: false
    t.enum "dinosaur_type", null: false, enum_type: "dinosaur_classification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_species_on_name", unique: true
  end

  add_foreign_key "dinosaurs", "cages"
  add_foreign_key "dinosaurs", "species"
end
