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

ActiveRecord::Schema.define(version: 20150331212248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "pseudoLoL"
    t.integer  "idLoL"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts_trackgroups", id: false, force: true do |t|
    t.integer "trackgroup_id"
    t.integer "account_id"
  end

  add_index "accounts_trackgroups", ["account_id"], name: "index_accounts_trackgroups_on_account_id", using: :btree
  add_index "accounts_trackgroups", ["trackgroup_id"], name: "index_accounts_trackgroups_on_trackgroup_id", using: :btree

  create_table "accounts_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "account_id"
  end

  add_index "accounts_users", ["account_id"], name: "index_accounts_users_on_account_id", using: :btree
  add_index "accounts_users", ["user_id"], name: "index_accounts_users_on_user_id", using: :btree

  create_table "dashboards", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "dashboards", ["user_id"], name: "index_dashboards_on_user_id", using: :btree

  create_table "information", force: true do |t|
    t.string   "title"
    t.text     "smallDescription"
    t.text     "detailedDescription"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_history_modules", force: true do |t|
    t.integer  "dashboard_id"
    t.integer  "account_id"
    t.integer  "nb_match"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_history_modules", ["account_id"], name: "index_match_history_modules_on_account_id", using: :btree
  add_index "match_history_modules", ["dashboard_id"], name: "index_match_history_modules_on_dashboard_id", using: :btree

  create_table "top_champions_modules", force: true do |t|
    t.integer  "dashboard_id"
    t.integer  "account_id"
    t.integer  "nb_champion"
    t.integer  "duration"
    t.string   "match_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "top_champions_modules", ["account_id"], name: "index_top_champions_modules_on_account_id", using: :btree
  add_index "top_champions_modules", ["dashboard_id"], name: "index_top_champions_modules_on_dashboard_id", using: :btree

  create_table "trackgroups", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "trackgroups", ["user_id"], name: "index_trackgroups_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                               null: false
    t.boolean  "admin",                  default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
