# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150302224721) do

  create_table "courses", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "room"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "price"
    t.integer  "capacity"
    t.integer  "first_period"
    t.integer  "second_period"
    t.integer  "third_period"
    t.integer  "event_id"
  end

  add_index "courses", ["event_id"], name: "index_courses_on_event_id"

  create_table "events", force: true do |t|
    t.string   "semester"
    t.string   "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "current",      default: false
    t.decimal  "event_price"
    t.decimal  "lunch_price"
    t.decimal  "tshirt_price"
    t.decimal  "patch_price"
  end

  create_table "preferences", force: true do |t|
    t.integer  "scout_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority"
    t.integer  "event_id"
  end

  add_index "preferences", ["event_id"], name: "index_preferences_on_event_id"

  create_table "records", force: true do |t|
    t.integer  "scout_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "period"
    t.string   "completion"
    t.integer  "event_id"
  end

  add_index "records", ["event_id"], name: "index_records_on_event_id"

  create_table "scouts", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "dob"
    t.string   "emergency_name"
    t.string   "emergency_relation"
    t.string   "emergency_phone"
    t.string   "notes"
    t.integer  "age"
    t.integer  "troop"
    t.boolean  "scout_lunch"
    t.integer  "additional_lunch"
    t.boolean  "patch"
    t.boolean  "shirt"
    t.string   "shirt_size"
    t.decimal  "cost"
  end

  add_index "scouts", ["user_id"], name: "index_scouts_on_user_id"

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.integer  "troop"
    t.string   "district"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.string   "council"
    t.decimal  "total_cost"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
