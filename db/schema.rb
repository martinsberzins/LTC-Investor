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

ActiveRecord::Schema.define(version: 20140718083835) do

  create_table "posts", force: true do |t|
    t.string   "name"
    t.string   "ticker"
    t.text     "description"
    t.string   "region"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
  end

  create_table "reports", force: true do |t|
    t.string   "quarter"
    t.date     "date_of_report"
    t.integer  "units"
    t.integer  "shares_outstanding"
    t.float    "high_price"
    t.float    "low_price"
    t.float    "percent_of_gov_income"
    t.integer  "revenue"
    t.integer  "opp_exp"
    t.integer  "ga_exp"
    t.integer  "rent"
    t.integer  "depreciation"
    t.integer  "interest_exp"
    t.integer  "tax"
    t.integer  "net_income"
    t.float    "tax_rate"
    t.integer  "assets"
    t.integer  "cash"
    t.integer  "curr_assets"
    t.integer  "goodwill"
    t.integer  "fixed_assets"
    t.integer  "curr_liab"
    t.integer  "curr_debt"
    t.integer  "lt_debt"
    t.integer  "equity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "total_liabilities"
    t.integer  "other_liabilities"
    t.integer  "other_assets"
  end

  add_index "reports", ["post_id"], name: "index_reports_on_post_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
