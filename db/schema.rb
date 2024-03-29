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

ActiveRecord::Schema[7.0].define(version: 2023_04_01_102229) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "user_agent"
    t.string "ip_address"
    t.string "remember_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["remember_token"], name: "index_active_sessions_on_remember_token", unique: true
    t.index ["user_id"], name: "index_active_sessions_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.string "title"
    t.string "username"
    t.string "password"
    t.string "url"
    t.string "notes"
    t.jsonb "data"
    t.string "entryable_type", null: false
    t.bigint "entryable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entryable_type", "entryable_id"], name: "index_entries_on_entryable"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "confirmed_at"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "active_sessions", "users", on_delete: :cascade
end
