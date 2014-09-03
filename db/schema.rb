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

ActiveRecord::Schema.define(version: 20140902074915) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "companies", ["name"], name: "index_companies_on_name", unique: true

  create_table "company_infos", force: true do |t|
    t.text     "description"
    t.string   "address"
    t.integer  "company_id"
    t.integer  "telephone"
    t.string   "email"
    t.decimal  "price",       precision: 6, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "company_infos", ["company_id"], name: "index_company_infos_on_company_id"
  add_index "company_infos", ["email"], name: "index_company_infos_on_email"

  create_table "identities", force: true do |t|
    t.string   "school_facility"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position"
  end

  add_index "identities", ["position"], name: "index_identities_on_position"
  add_index "identities", ["user_id", "school_facility"], name: "index_identities_on_user_id_and_school_facility"

  create_table "instructor_infos", force: true do |t|
    t.text     "description"
    t.decimal  "price",         precision: 6, scale: 2
    t.integer  "instructor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructor_infos", ["instructor_id", "price"], name: "index_instructor_infos_on_instructor_id_and_price"

  create_table "instructors", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.boolean  "companyadmin",    default: false
    t.string   "facility"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.integer  "company_id"
  end

  add_index "instructors", ["email"], name: "index_instructors_on_email", unique: true
  add_index "instructors", ["facility"], name: "index_instructors_on_facility"
  add_index "instructors", ["remember_token"], name: "index_instructors_on_remember_token"

  create_table "user_infos", force: true do |t|
    t.text     "description"
    t.integer  "feet",        limit: 1
    t.integer  "inches",      limit: 2
    t.decimal  "weight",                precision: 5, scale: 2
    t.string   "school"
    t.integer  "year",        limit: 4
    t.string   "position"
    t.string   "team"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_infos", ["position"], name: "index_user_infos_on_position"
  add_index "user_infos", ["school"], name: "index_user_infos_on_school"
  add_index "user_infos", ["team"], name: "index_user_infos_on_team"
  add_index "user_infos", ["user_id"], name: "index_user_infos_on_user_id"
  add_index "user_infos", ["year"], name: "index_user_infos_on_year"

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

  create_table "videos", force: true do |t|
    t.string   "title"
    t.string   "panda_video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "people_id"
    t.string   "people_type"
  end

end
