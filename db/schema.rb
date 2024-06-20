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

ActiveRecord::Schema[7.1].define(version: 2024_06_20_204006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "album_details", force: :cascade do |t|
    t.bigint "external_id", null: false
    t.text "description"
    t.string "url"
    t.string "thumbnail_url"
    t.bigint "album_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["album_id"], name: "index_album_details_on_album_id"
    t.index ["external_id"], name: "index_album_details_on_external_id", unique: true
  end

  create_table "albums", force: :cascade do |t|
    t.bigint "external_id", null: false
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_albums_on_external_id", unique: true
    t.index ["user_id"], name: "index_albums_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.bigint "external_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.string "user_name", null: false
    t.string "phone"
    t.jsonb "other_infos", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["external_id"], name: "index_users_on_external_id", unique: true
  end

  add_foreign_key "album_details", "albums"
  add_foreign_key "albums", "users"
end
