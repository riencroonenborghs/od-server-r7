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

ActiveRecord::Schema.define(version: 2021_12_27_210722) do

  create_table "downloads", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "url", null: false
    t.string "type"
    t.integer "status", default: 0, null: false
    t.string "http_username"
    t.string "http_password"
    t.string "filter"
    t.boolean "youtube_audio", default: false, null: false
    t.string "youtube_audio_format"
    t.boolean "youtube_subs", default: false, null: false
    t.boolean "youtube_srt_subs", default: false, null: false
    t.datetime "started_at", precision: 6
    t.datetime "finished_at", precision: 6
    t.datetime "cancelled_at", precision: 6
    t.datetime "failed_at", precision: 6
    t.string "error_message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_downloads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at", precision: 6
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.datetime "last_sign_in_at", precision: 6
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "downloads", "users"
end
