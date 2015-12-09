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

ActiveRecord::Schema.define(version: 20151208210429) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "intarray"

  create_table "accounts", force: :cascade do |t|
    t.string   "host",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_events", force: :cascade do |t|
    t.integer  "app_id",     null: false
    t.string   "query",      null: false
    t.string   "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "app_funnel_event_definitions", force: :cascade do |t|
    t.integer  "app_funnel_id",       null: false
    t.integer  "event_definition_id", null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "app_funnel_event_definitions", ["app_funnel_id"], name: "index_app_funnel_event_definitions_on_app_funnel_id", using: :btree
  add_index "app_funnel_event_definitions", ["event_definition_id"], name: "index_app_funnel_event_definitions_on_event_definition_id", using: :btree

  create_table "app_funnels", force: :cascade do |t|
    t.integer  "app_id",     null: false
    t.string   "title",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "app_funnels", ["app_id"], name: "index_app_funnels_on_app_id", using: :btree

  create_table "app_hosts", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "host",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "app_hosts", ["app_id", "host"], name: "index_app_hosts_on_app_id_and_host", unique: true, using: :btree
  add_index "app_hosts", ["app_id"], name: "index_app_hosts_on_app_id", using: :btree

  create_table "app_identified_users", force: :cascade do |t|
    t.integer  "app_id"
    t.integer  "userId",     limit: 8, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "handle",               null: false
    t.string   "email"
  end

  add_index "app_identified_users", ["app_id", "handle"], name: "index_app_identified_users_on_app_id_and_handle", unique: true, using: :btree
  add_index "app_identified_users", ["app_id", "userId"], name: "index_app_identified_users_on_app_id_and_userId", unique: true, using: :btree
  add_index "app_identified_users", ["app_id"], name: "index_app_identified_users_on_app_id", using: :btree

  create_table "app_identifies", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "email"
    t.string   "handle",     null: false
    t.string   "sessionId",  null: false
    t.string   "visitId",    null: false
    t.string   "userId",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "app_identifies", ["app_id"], name: "index_app_identifies_on_app_id", using: :btree

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

  create_table "app_pages", force: :cascade do |t|
    t.integer  "app_id"
    t.string   "host",                     null: false
    t.string   "path",       default: "/", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "app_pages", ["app_id", "host", "path"], name: "index_app_pages_on_app_id_and_host_and_path", unique: true, using: :btree
  add_index "app_pages", ["app_id"], name: "index_app_pages_on_app_id", using: :btree

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
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "title"
    t.integer  "event_definitions_count",    default: 0, null: false
    t.integer  "account_id",                             null: false
    t.integer  "app_user_sessions_count",    default: 0, null: false
    t.integer  "app_user_visits_count",      default: 0, null: false
    t.integer  "app_events_count",           default: 0, null: false
    t.integer  "app_users_count",            default: 0, null: false
    t.integer  "app_sessions_count",         default: 0, null: false
    t.integer  "app_page_events_count",      default: 0, null: false
    t.integer  "app_identifies_count",       default: 0, null: false
    t.integer  "app_identified_users_count", default: 0, null: false
    t.integer  "app_visits_count",           default: 0, null: false
    t.integer  "app_pages_count",            default: 0, null: false
  end

  create_table "event_applies", force: :cascade do |t|
    t.integer  "app_id",              null: false
    t.integer  "event_definition_id", null: false
    t.integer  "app_page_event_id",   null: false
    t.datetime "time",                null: false
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "event_definition_user_applies", force: :cascade do |t|
    t.integer  "event_definition_id",           null: false
    t.integer  "app_id",                        null: false
    t.integer  "app_page_event_id",             null: false
    t.datetime "time",                          null: false
    t.integer  "userId",              limit: 8, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "event_definition_user_applies", ["event_definition_id", "userId"], name: "edua_uniq", unique: true, using: :btree

  create_table "event_definitions", force: :cascade do |t|
    t.integer  "app_id",                      null: false
    t.string   "title",                       null: false
    t.string   "event_type",                  null: false
    t.string   "element_classes",                          array: true
    t.string   "element_tag"
    t.string   "element_id"
    t.string   "href"
    t.string   "inner_text"
    t.string   "dom_path",                                 array: true
    t.integer  "events_count",    default: 0, null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "users_count",     default: 0, null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "role",       default: "guest", null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "memberships", ["account_id", "user_id"], name: "index_memberships_on_account_id_and_user_id", unique: true, using: :btree
  add_index "memberships", ["account_id"], name: "index_memberships_on_account_id", using: :btree
  add_index "memberships", ["user_id"], name: "index_memberships_on_user_id", using: :btree

  create_table "requests", force: :cascade do |t|
    t.string   "site"
    t.string   "email_or_phone"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "pin_code",           null: false
    t.string   "phone_confirmed"
    t.string   "string"
    t.datetime "phone_confirmed_at"
    t.string   "email_confirmed"
    t.datetime "email_confirmed_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "crypted_password"
    t.string   "salt"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", unique: true, using: :btree

  add_foreign_key "app_funnel_event_definitions", "app_funnels"
  add_foreign_key "app_funnel_event_definitions", "event_definitions"
  add_foreign_key "app_funnels", "apps"
  add_foreign_key "app_hosts", "apps"
  add_foreign_key "app_identified_users", "apps"
  add_foreign_key "app_identifies", "apps"
  add_foreign_key "app_pages", "apps"
  add_foreign_key "memberships", "accounts"
  add_foreign_key "memberships", "users"
end
