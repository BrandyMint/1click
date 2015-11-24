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

ActiveRecord::Schema.define(version: 20151124143532) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "intarray"

  create_table "app_events", force: :cascade do |t|
    t.integer  "app_id",     null: false
    t.hstore   "params"
    t.string   "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_page_events", force: :cascade do |t|
    t.datetime "time",                                   null: false
    t.integer  "app_id",                                 null: false
    t.integer  "userId",          limit: 8,              null: false
    t.integer  "sessionId",       limit: 8,              null: false
    t.integer  "visitId",         limit: 8,              null: false
    t.string   "event_type",                             null: false
    t.string   "element_classes",           default: [], null: false, array: true
    t.string   "element_tag",                            null: false
    t.string   "element_id"
    t.string   "href"
    t.string   "dom_path",                  default: [], null: false, array: true
    t.string   "inner_text"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "app_user_sessions", force: :cascade do |t|
    t.integer  "app_id",                                  null: false
    t.integer  "userId",            limit: 8,             null: false
    t.integer  "sessionId",         limit: 8,             null: false
    t.integer  "visits_count",                default: 0, null: false
    t.integer  "page_events_count",           default: 0, null: false
    t.string   "user_agent"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "app_user_sessions", ["app_id", "userId", "sessionId"], name: "index_app_user_sessions_on_app_id_and_userId_and_sessionId", using: :btree

  create_table "app_user_visits", force: :cascade do |t|
    t.datetime "time",                                       null: false
    t.integer  "app_id",                                     null: false
    t.integer  "userId",               limit: 8,             null: false
    t.integer  "sessionId",            limit: 8,             null: false
    t.integer  "visitId",              limit: 8,             null: false
    t.string   "fragment"
    t.string   "path",                                       null: false
    t.string   "query"
    t.string   "domain",                                     null: false
    t.string   "title"
    t.string   "referer"
    t.string   "referer_search_query"
    t.string   "utm_source"
    t.string   "utm_medium"
    t.string   "utm_term"
    t.string   "utm_content"
    t.string   "utm_campaign"
    t.integer  "page_events_count",              default: 0, null: false
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "app_user_visits", ["app_id", "userId", "sessionId", "visitId"], name: "app_user_visits_unique_index", using: :btree

  create_table "app_users", force: :cascade do |t|
    t.integer  "app_id",                               null: false
    t.integer  "userId",         limit: 8,             null: false
    t.integer  "sessions_count",           default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "app_users", ["app_id", "userId"], name: "index_app_users_on_app_id_and_userId", using: :btree

  create_table "apps", force: :cascade do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "event_definitions_count", default: 0, null: false
  end

  create_table "event_definitions", force: :cascade do |t|
    t.integer  "app_id",                       null: false
    t.string   "title",                        null: false
    t.string   "event_type",                   null: false
    t.string   "element_classes", default: [],              array: true
    t.string   "element_tag"
    t.string   "element_id"
    t.string   "href"
    t.string   "dom_path",        default: [],              array: true
    t.string   "inner_text"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

end
