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

ActiveRecord::Schema.define(version: 20150226202540) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: true do |t|
    t.string   "pseudoLoL"
    t.integer  "idLoL"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackgroups", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackgroups_accounts", id: false, force: true do |t|
    t.integer "trackgroup_id"
    t.integer "account_id"
  end

  add_index "trackgroups_accounts", ["account_id"], name: "index_trackgroups_accounts_on_account_id", using: :btree
  add_index "trackgroups_accounts", ["trackgroup_id"], name: "index_trackgroups_accounts_on_trackgroup_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_accounts", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "account_id"
  end

  add_index "users_accounts", ["account_id"], name: "index_users_accounts_on_account_id", using: :btree
  add_index "users_accounts", ["user_id"], name: "index_users_accounts_on_user_id", using: :btree

  create_table "users_trackgroups", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "trackgroup_id"
  end

  add_index "users_trackgroups", ["trackgroup_id"], name: "index_users_trackgroups_on_trackgroup_id", using: :btree
  add_index "users_trackgroups", ["user_id"], name: "index_users_trackgroups_on_user_id", using: :btree

end