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

ActiveRecord::Schema.define(version: 2022_09_27_210502) do

  create_table "characters", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.float "weight"
    t.string "history"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "characters_productions", id: false, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "production_id", null: false
    t.index ["character_id", "production_id"], name: "index_characters_productions_on_character_id_and_production_id"
    t.index ["production_id", "character_id"], name: "index_characters_productions_on_production_id_and_character_id"
  end

  create_table "characters_studios", id: false, force: :cascade do |t|
    t.integer "character_id", null: false
    t.integer "studio_id", null: false
    t.index ["character_id", "studio_id"], name: "index_characters_studios_on_character_id_and_studio_id"
    t.index ["studio_id", "character_id"], name: "index_characters_studios_on_studio_id_and_character_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "genres_productions", id: false, force: :cascade do |t|
    t.integer "genre_id", null: false
    t.integer "production_id", null: false
    t.index ["genre_id", "production_id"], name: "index_genres_productions_on_genre_id_and_production_id"
    t.index ["production_id", "genre_id"], name: "index_genres_productions_on_production_id_and_genre_id"
  end

  create_table "productions", force: :cascade do |t|
    t.string "title"
    t.integer "score"
    t.date "released_date"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "productions_studios", id: false, force: :cascade do |t|
    t.integer "production_id", null: false
    t.integer "studio_id", null: false
    t.index ["production_id", "studio_id"], name: "index_productions_studios_on_production_id_and_studio_id"
    t.index ["studio_id", "production_id"], name: "index_productions_studios_on_studio_id_and_production_id"
  end

  create_table "studios", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.date "foundation_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
