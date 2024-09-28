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

ActiveRecord::Schema[7.0].define(version: 2024_09_27_221547) do
  create_table "downloads", force: :cascade do |t|
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
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "cancelled_at"
    t.datetime "failed_at"
    t.string "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "download_type", default: 0
  end

  create_table "searches", force: :cascade do |t|
    t.string "query"
    t.integer "query_type", default: 0, null: false
    t.boolean "alternative"
    t.boolean "quoted"
    t.boolean "incognito"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
