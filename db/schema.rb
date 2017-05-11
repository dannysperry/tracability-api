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

ActiveRecord::Schema.define(version: 20170510163324) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.integer  "state_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id", using: :btree
  end

  create_table "growing_media", force: :cascade do |t|
    t.integer  "room_section_id"
    t.integer  "medium_type",                 null: false
    t.string   "name",                        null: false
    t.string   "barcode",                     null: false
    t.integer  "quantity",        default: 1, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["room_section_id"], name: "index_growing_media_on_room_section_id", using: :btree
  end

  create_table "growing_stages", force: :cascade do |t|
    t.string   "name",        null: false
    t.text     "description"
    t.integer  "license_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["license_id"], name: "index_growing_stages_on_license_id", using: :btree
  end

  create_table "inventory_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "licenses", force: :cascade do |t|
    t.string   "license_number", null: false
    t.integer  "license_type",   null: false
    t.integer  "state_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["license_number"], name: "index_licenses_on_license_number", unique: true, using: :btree
    t.index ["state_id"], name: "index_licenses_on_state_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "license_id"
    t.integer  "city_id"
    t.string   "name",           null: false
    t.string   "street_address", null: false
    t.string   "phone_number"
    t.integer  "area_in_inches", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["city_id"], name: "index_locations_on_city_id", using: :btree
    t.index ["license_id"], name: "index_locations_on_license_id", using: :btree
  end

  create_table "notes", force: :cascade do |t|
    t.text     "description"
    t.string   "name",         null: false
    t.string   "notable_type"
    t.integer  "notable_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["notable_type", "notable_id"], name: "index_notes_on_notable_type_and_notable_id", using: :btree
  end

  create_table "patients", force: :cascade do |t|
    t.string   "name",                           null: false
    t.string   "street_address",                 null: false
    t.boolean  "is_medical",     default: false, null: false
    t.integer  "physician_id"
    t.integer  "city_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["city_id"], name: "index_patients_on_city_id", using: :btree
    t.index ["physician_id"], name: "index_patients_on_physician_id", using: :btree
  end

  create_table "physicians", force: :cascade do |t|
    t.string   "name",           null: false
    t.string   "license_number", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["license_number"], name: "index_physicians_on_license_number", unique: true, using: :btree
  end

  create_table "regulations", force: :cascade do |t|
    t.string   "legal_reference_code", null: false
    t.text     "description"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "room_sections", force: :cascade do |t|
    t.string   "name",                             null: false
    t.integer  "area_in_inches",                   null: false
    t.integer  "section_type",     default: 0
    t.boolean  "is_growing_space", default: false
    t.integer  "room_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["room_id"], name: "index_room_sections_on_room_id", using: :btree
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "room_type",                        null: false
    t.string   "name",                             null: false
    t.integer  "area_in_inches",                   null: false
    t.boolean  "is_growing_space", default: false
    t.integer  "location_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["location_id"], name: "index_rooms_on_location_id", using: :btree
  end

  create_table "states", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "abbreviation", limit: 2, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "strains", force: :cascade do |t|
    t.string   "name",             null: false
    t.float    "expected_potency"
    t.float    "expected_yield"
    t.integer  "veg_days"
    t.integer  "flower_days"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer  "license_id"
    t.string   "vin"
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["license_id"], name: "index_vehicles_on_license_id", using: :btree
  end

  create_table "weights", force: :cascade do |t|
    t.string   "weighable_type"
    t.integer  "weighable_id"
    t.float    "amount",                     null: false
    t.integer  "amount_type",    default: 0
    t.integer  "weight_type",    default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.index ["weighable_type", "weighable_id"], name: "index_weights_on_weighable_type_and_weighable_id", using: :btree
  end

  add_foreign_key "cities", "states"
  add_foreign_key "licenses", "states"
  add_foreign_key "locations", "cities"
  add_foreign_key "locations", "licenses"
  add_foreign_key "vehicles", "licenses"
end
