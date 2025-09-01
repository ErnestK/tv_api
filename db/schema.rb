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

ActiveRecord::Schema[7.1].define(version: 2025_09_01_185306) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gist"
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.datetime "created_at", precision: nil
  end

  create_table "channel_programs", force: :cascade do |t|
    t.bigint "channel_id", null: false
    t.tstzrange "time_range", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["channel_id", "time_range"], name: "idx_channel_programs_channel_time_composite", using: :gist
  end

  create_table "channels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contents", force: :cascade do |t|
    t.string "original_name", limit: 255, null: false
    t.string "contentable_type", limit: 50, null: false
    t.bigint "contentable_id", null: false
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contentable_type", "contentable_id"], name: "idx_content_polymorphic", unique: true
  end

  create_table "movies", force: :cascade do |t|
    t.integer "duration_in_seconds", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tv_shows", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tv_shows_seasons", force: :cascade do |t|
    t.bigint "tv_show_id", null: false
    t.integer "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_show_id", "number"], name: "idx_seasons_show_number", unique: true
  end

  create_table "tv_shows_seasons_episodes", force: :cascade do |t|
    t.bigint "tv_shows_season_id", null: false
    t.integer "number", null: false
    t.integer "duration_in_seconds", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tv_shows_season_id", "number"], name: "idx_episodes_season_number", unique: true
  end

  add_foreign_key "channel_programs", "channels"
  add_foreign_key "tv_shows_seasons", "tv_shows"
  add_foreign_key "tv_shows_seasons_episodes", "tv_shows_seasons"
end
